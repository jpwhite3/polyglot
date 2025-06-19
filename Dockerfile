FROM ubuntu:mantic

SHELL ["/bin/bash", "-c"]

ENV TZ='America/New_York'
RUN apt update \
	&& apt upgrade -y \
	&& apt install software-properties-common -y \
	&& DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
	curl \
	wget \
	sudo \
	apt-utils \
	apt-transport-https \
	g++ \
	gcc \
	git \
	make \
	p7zip-full \
	unzip \
	xz-utils \
	jq \
	vim \
	tree \
	less \
	libc6-dev \
	dirmngr \
	gpg gpg-agent \
	ca-certificates \
	zsh \
	# PYTHON LATEST
	python3 python3-dev python3-venv python3-pip \
	# JAVA LATEST
	openjdk-20-jdk-headless \
	# .NET-CORE LATEST
	dotnet6 \
	# Ruby LATEST
	ruby-full rbenv \
	# CLEAN UP
	&& apt-get purge --auto-remove -y \
	&& apt-get clean \
	&& rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# Zshell Configuration
RUN chsh -s $(which zsh)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
COPY polyglot.zsh-theme /root/.oh-my-zsh/themes/polyglot.zsh-theme
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="polyglot"/' /root/.zshrc

# Git Configuration
RUN \
	git config --global pull.rebase true \
	&& git config --global init.defaultbranch main \
	&& git config --global fetch.prune true \
	&& git config --global diff.colorMoved zebra

# Python configuration
RUN \
	ln -s /usr/bin/python3 /usr/bin/python \
	&& python -m pip install --upgrade pip setuptools wheel poetry pipenv --break-system-packages

# GO installation
RUN \
	curl -OL https://go.dev/dl/go1.24.4.linux-amd64.tar.gz \
	&& tar -C /usr/local -xvf go1.24.4.linux-amd64.tar.gz \
	&& ln -s /usr/local/go/bin/go /usr/bin/go

# Node installation with nvm 
ENV NODE_VERSION lts/iron
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash \
	&& . ~/.nvm/nvm.sh \
	&& nvm install $NODE_VERSION \
	&& nvm alias default $NODE_VERSION \
	&& nvm use default \
	&& ln -s $(which node) /usr/bin/node \
	&& ln -s $(which npm) /usr/bin/npm

# Rust installation
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Docker installation
RUN curl -fsSL https://get.docker.com | sh

# Print versions
RUN \
	echo "Tool versions:" \
	&& python --version \
	&& pip --version \
	&& poetry --version \
	&& pipenv --version \
	&& java -version \
	&& go version \
	&& dotnet --version \
	&& node --version \
	&& npm --version \
	&& rustup --version \
	&& rustc --version \
	&& ruby --version \
	&& gem --version \
	&& rbenv --version \
	&& docker --version

