# Stage 1: Base system with common dependencies
FROM ubuntu:24.04 AS base


SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV TZ='America/New_York' \
	DEBIAN_FRONTEND="noninteractive" \
	NVM_DIR="/root/.nvm" \
	PATH="/root/.cargo/bin:/root/.nvm/current/bin:/usr/local/go/bin:${PATH}"

# Install common packages in a single layer with proper cleanup
RUN apt-get update && \
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
	# libc6-dev \
	make \
	software-properties-common \
	sudo \
	tree \
	unzip \
	zip \
	vim \
	wget \
	# xz-utils \
	zsh && \
	# Clean up in the same layer to reduce image size
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Stage 2: Language-specific installations
FROM base AS languages

# Add repositories and install programming languages in a single layer.
# Versions are resolved dynamically so each build pulls the latest available
# from the distro repos.
RUN apt-get update && \
	# Python (latest available in distro)
	apt-get install -y --no-install-recommends python3 python3-dev python3-venv python3-pip && \
	ln -s /usr/bin/python3 /usr/bin/python && \
	# Java: discover the highest openjdk-N-jdk package available
	JDK_PKG=$(apt-cache pkgnames openjdk- | grep -E '^openjdk-[0-9]+-jdk$' | sort -V | tail -1) && \
	echo "Installing Java: $JDK_PKG" && \
	apt-get install -y --no-install-recommends "$JDK_PKG" && \
	# .NET: discover the highest dotnet-sdk-X.Y available and install matching runtime
	DOTNET_VER=$(apt-cache pkgnames dotnet-sdk- | grep -E '^dotnet-sdk-[0-9]+\.[0-9]+$' | sed 's/^dotnet-sdk-//' | sort -V | tail -1) && \
	echo "Installing .NET: $DOTNET_VER" && \
	apt-get install -y --no-install-recommends "dotnet-sdk-$DOTNET_VER" "dotnet-runtime-$DOTNET_VER" && \
	# Ruby (latest available in distro)
	apt-get install -y --no-install-recommends ruby-full rbenv && \
	# Clean up
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Stage 3: Tool installations (Go, Node, Rust, Docker)
FROM languages AS tools

# Install Go (auto-detect the latest stable version from go.dev)
RUN GO_VERSION=$(curl -fsSL https://go.dev/VERSION?m=text | head -n1 | sed 's/^go//') && \
	GO_TARBALL="go${GO_VERSION}.linux-amd64.tar.gz" && \
	echo "Installing Go: ${GO_VERSION}" && \
	curl -OL "https://go.dev/dl/${GO_TARBALL}" && \
	tar -C /usr/local -xf "${GO_TARBALL}" && \
	rm "${GO_TARBALL}" && \
	ln -sf /usr/local/go/bin/go /usr/bin/go

# Install Node.js with nvm.
# - Uses the latest nvm release tag from GitHub
# - Installs the current LTS line of Node
# - Creates a stable $NVM_DIR/current symlink so the ENV PATH stays valid
#   across version changes
RUN NVM_VERSION=$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name') && \
	echo "Installing nvm: ${NVM_VERSION}" && \
	curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash && \
	. $NVM_DIR/nvm.sh && \
	nvm install --lts && \
	nvm alias default 'lts/*' && \
	nvm use default && \
	NODE_VER=$(nvm version default) && \
	ln -sfn "$NVM_DIR/versions/node/$NODE_VER" "$NVM_DIR/current" && \
	ln -sf "$NVM_DIR/current/bin/node" /usr/bin/node && \
	ln -sf "$NVM_DIR/current/bin/npm" /usr/bin/npm

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

# Install Docker
RUN curl -fsSL https://get.docker.com | sh

# Stage 4: Python packages and configuration
FROM tools AS python-config

RUN python -m pip install --no-cache-dir pipx poetry pipenv --break-system-packages

# Stage 5: Final image with configurations
FROM python-config AS final

# Git Configuration
RUN git config --global pull.rebase true && \
	git config --global init.defaultbranch main && \
	git config --global fetch.prune true && \
	git config --global diff.colorMoved zebra

# Zshell Configuration
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
	chsh -s $(which zsh)

# Copy theme file
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
	docker --version

# Set default shell to zsh
CMD ["zsh"]
