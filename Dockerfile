# syntax=docker/dockerfile:1.7

# Stage 1: Base system with common dependencies
FROM ubuntu:24.04 AS base

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV TZ='America/New_York' \
	DEBIAN_FRONTEND="noninteractive" \
	NVM_DIR="/root/.nvm" \
	PATH="/root/.cargo/bin:/root/.nvm/current/bin:/usr/local/go/bin:${PATH}"

# Disable apt's automatic post-install cache wipe so BuildKit cache mounts can
# actually retain downloads across builds.
RUN rm -f /etc/apt/apt.conf.d/docker-clean && \
	echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' \
		> /etc/apt/apt.conf.d/keep-cache

# Install common packages. /var/cache/apt and /var/lib/apt are mounted as
# BuildKit caches so .deb files and package indexes persist outside the image
# layer; no manual apt-get clean / rm -rf is needed afterwards.
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
		apt-transport-https \
		apt-utils \
		ca-certificates \
		curl \
		g++ \
		gcc \
		git \
		gpg \
		gpg-agent \
		jq \
		less \
		make \
		software-properties-common \
		sudo \
		tree \
		unzip \
		zip \
		vim \
		wget \
		zsh

# Stage 2: Language-specific installations.
# Versions resolved dynamically; smaller-footprint variants chosen where safe:
#  - Java: openjdk-N-jdk-headless (no Swing/AWT, ~200MB smaller)
#  - .NET: SDK only (the SDK already ships with the matching runtime)
FROM base AS languages

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		python3 python3-dev python3-venv python3-pip && \
	ln -s /usr/bin/python3 /usr/bin/python && \
	JDK_PKG=$(apt-cache pkgnames openjdk- | grep -E '^openjdk-[0-9]+-jdk-headless$' | sort -V | tail -1) && \
	echo "Installing Java (headless): $JDK_PKG" && \
	apt-get install -y --no-install-recommends "$JDK_PKG" && \
	DOTNET_VER=$(apt-cache pkgnames dotnet-sdk- | grep -E '^dotnet-sdk-[0-9]+\.[0-9]+$' | sed 's/^dotnet-sdk-//' | sort -V | tail -1) && \
	echo "Installing .NET SDK: $DOTNET_VER" && \
	apt-get install -y --no-install-recommends "dotnet-sdk-$DOTNET_VER" && \
	apt-get install -y --no-install-recommends ruby-full rbenv

# Stage 3: Tool installations (Go, Node, Rust, Docker CLI)
FROM languages AS tools

# Install Go (auto-detect the latest stable version from go.dev), then strip
# the bundled docs/test/api directories which are not needed at runtime
# (~100MB smaller).
RUN GO_VERSION=$(curl -fsSL https://go.dev/VERSION?m=text | head -n1 | sed 's/^go//') && \
	GO_TARBALL="go${GO_VERSION}.linux-amd64.tar.gz" && \
	echo "Installing Go: ${GO_VERSION}" && \
	curl -OL "https://go.dev/dl/${GO_TARBALL}" && \
	tar -C /usr/local -xf "${GO_TARBALL}" && \
	rm "${GO_TARBALL}" && \
	rm -rf /usr/local/go/doc /usr/local/go/test /usr/local/go/api && \
	ln -sf /usr/local/go/bin/go /usr/bin/go

# Install Node.js with nvm (latest LTS) and clear nvm's tarball cache after.
RUN NVM_VERSION=$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name') && \
	echo "Installing nvm: ${NVM_VERSION}" && \
	curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash && \
	. $NVM_DIR/nvm.sh && \
	nvm install --lts --no-progress && \
	nvm alias default 'lts/*' && \
	nvm use default && \
	NODE_VER=$(nvm version default) && \
	ln -sfn "$NVM_DIR/versions/node/$NODE_VER" "$NVM_DIR/current" && \
	ln -sf "$NVM_DIR/current/bin/node" /usr/bin/node && \
	ln -sf "$NVM_DIR/current/bin/npm" /usr/bin/npm && \
	nvm cache clear

# Install Rust with the minimal profile (drops rust-docs, ~700MB smaller),
# then add clippy and rustfmt which most dev workflows expect.
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
		bash -s -- -y --profile minimal --default-toolchain stable --no-modify-path && \
	. /root/.cargo/env && \
	rustup component add clippy rustfmt

# Install Docker CLI + buildx + compose plugins from Docker's official apt
# repo. The daemon (docker-ce) and containerd are intentionally omitted; the
# typical use is to mount the host docker socket into the container, and
# skipping them saves ~600MB.
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	install -m 0755 -d /etc/apt/keyrings && \
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
		-o /etc/apt/keyrings/docker.asc && \
	chmod a+r /etc/apt/keyrings/docker.asc && \
	UBUNTU_CODENAME=$(. /etc/os-release && echo "$VERSION_CODENAME") && \
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable" \
		> /etc/apt/sources.list.d/docker.list && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		docker-ce-cli \
		docker-buildx-plugin \
		docker-compose-plugin

# Stage 4: Python packages and configuration
FROM tools AS python-config

RUN --mount=type=cache,target=/root/.cache/pip \
	python -m pip install pipx poetry pipenv --break-system-packages

# Stage 5: Agentic AI coding tools.
# Each installer is the upstream "latest" curl|bash script, so the image always
# picks up the newest release on rebuild. The tools drop binaries under
# /root/.local/bin or /root/.opencode/bin; we mirror those into ENV PATH so
# the binaries are usable from any shell.
FROM python-config AS ai-tools

ENV PATH="/root/.local/bin:/root/.opencode/bin:${PATH}"

RUN curl -fsSL https://claude.ai/install.sh | bash && \
	curl -fsSL https://antigravity.google/cli/install.sh | bash && \
	curl -fsSL https://opencode.ai/install | bash

# Stage 6: Final image with shell configurations
FROM ai-tools AS final

# Git config + Oh My Zsh in a single layer.
RUN git config --global pull.rebase true && \
	git config --global init.defaultbranch main && \
	git config --global fetch.prune true && \
	git config --global diff.colorMoved zebra && \
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
	chsh -s "$(which zsh)"

COPY polyglot.zsh-theme /root/.oh-my-zsh/themes/polyglot.zsh-theme
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="polyglot"/' /root/.zshrc

# Print versions for verification
RUN echo "Tool versions:" && \
	python --version && \
	pip --version && \
	poetry --version && \
	pipenv --version && \
	java -version && \
	go version && \
	dotnet --version && \
	. $NVM_DIR/nvm.sh && \
	node --version && \
	npm --version && \
	rustup --version && \
	rustc --version && \
	ruby --version && \
	gem --version && \
	rbenv --version && \
	docker --version && \
	echo "Agentic AI tools:" && \
	command -v claude && \
	command -v opencode && \
	command -v agy

CMD ["zsh"]
