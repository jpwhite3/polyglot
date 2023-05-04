FROM ubuntu:22.10

ENV TZ='America/New_York'
RUN apt update \
	&& apt upgrade -y \
	&& apt install software-properties-common -y \
	&& add-apt-repository ppa:deadsnakes/ppa \
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
	# PYTHON LATEST
	python3 python3-dev python3-venv python3-pip \
	# JAVA LATEST
	openjdk-18-jdk-headless maven \
	# .NET-CORE LATEST
	dotnet6 \	
	# CLEAN UP
	&& apt-get purge --auto-remove -y \
	&& apt-get clean \
	&& rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# Git Configuration
RUN \
	git config --global pull.rebase true \
	&& git config --global fetch.prune true \
	&& git config --global diff.colorMoved zebra

# Gradle Installation
RUN \
	wget -nv https://services.gradle.org/distributions/gradle-7.4.2-bin.zip -P /tmp \
	&& mkdir /opt/gradle \
	&& unzip -d /opt/gradle /tmp/gradle-7.4.2-bin.zip \
	&& echo "export GRADLE_HOME=/opt/gradle/gradle-7.4.2" >> /etc/profile.d/gradle.sh \
	&& echo "export PATH=${GRADLE_HOME}/bin:${PATH}" >> /etc/profile.d/gradle.sh \
	&& chmod +x /etc/profile.d/gradle.sh \
	&& rm -f /tmp/gradle-7.4.2-bin.zip \
	&& ln -s /opt/gradle/gradle-7.4.2/bin/gradle /usr/bin/gradle

# Python configuration
RUN \
	ln -s /usr/bin/python3 /usr/bin/python \
	&& python -m pip install --upgrade pip setuptools wheel poetry pipenv

# GO installation
RUN \
	curl -OL https://go.dev/dl/go1.19.4.linux-amd64.tar.gz \
	&& tar -C /usr/local -xvf go1.19.4.linux-amd64.tar.gz \
	&& ln -s /usr/local/go/bin/go /usr/bin/go

# Node installation with nvm 
ENV NODE_VERSION lts/hydrogen
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
	&& . ~/.nvm/nvm.sh \
	&& nvm install $NODE_VERSION \
	&& nvm alias default $NODE_VERSION \
	&& nvm use default \
	&& ln -s $(which node) /usr/bin/node \
	&& ln -s $(which npm) /usr/bin/npm

# Print versions
RUN \
	echo "Tool versions:" \
	&& python --version \
	&& pip --version \
	&& java -version \
	&& mvn --version \
	&& gradle --version \
	&& go version \
	&& dotnet --version \
	&& node --version \
	&& npm --version
