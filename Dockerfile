# Stage 1: Base system with common dependencies
FROM ubuntu:24.04 AS base


SHELL ["/bin/bash", "-c"]
ENV TZ='America/New_York' \
	DEBIAN_FRONTEND="noninteractive" \
	PATH="/root/.cargo/bin:/root/.nvm/versions/node/v22.16.0/bin:/usr/local/go/bin:${PATH}" \
	NVM_DIR="/root/.nvm" \
	NODE_VERSION="lts/jod"

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

# Add repositories and install programming languages in a single layer
RUN apt-get update && \
	# Python
	apt-get install -y --no-install-recommends python3 python3-dev python3-venv python3-pip && \
	ln -s /usr/bin/python3 /usr/bin/python && \
	# Java
	apt-get install -y --no-install-recommends openjdk-21-jdk && \
	# .NET
	apt-get install -y --no-install-recommends dotnet-sdk-8.0 dotnet-runtime-8.0 && \
	# Ruby
	apt-get install -y --no-install-recommends ruby-full rbenv && \
	# Clean up
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Stage 3: Tool installations (Go, Node, Rust, Docker)
FROM languages AS tools

# Install Go
RUN curl -OL https://go.dev/dl/go1.24.4.linux-amd64.tar.gz && \
	tar -C /usr/local -xf go1.24.4.linux-amd64.tar.gz && \
	rm go1.24.4.linux-amd64.tar.gz && \
	ln -sf /usr/local/go/bin/go /usr/bin/go

# Install Node.js with nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
	. $NVM_DIR/nvm.sh && \
	nvm install $NODE_VERSION && \
	nvm alias default $NODE_VERSION && \
	nvm use default && \
	ln -sf $(. $NVM_DIR/nvm.sh && which node) /usr/bin/node && \
	ln -sf $(. $NVM_DIR/nvm.sh && which npm) /usr/bin/npm

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
