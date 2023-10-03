![Docker](https://github.com/jpwhite3/polyglot/workflows/Docker/badge.svg)

# Polyglot

Multi programming language container image built for interactive development environments like:

- [Coder](https://coder.com)
- [GitHub Codespaces](https://github.com/features/codespaces)
- [JupyterLab](https://jupyter.org)
- CICD Systems
- etc.

_NOTE:_ This image is on the large side, around 2.5GB in total. This makes it too big for most large scale uses. But in small scale it seems to work quite well despite its size.

## Base Image

This image is based on Ubuntu 23.10 (mantic)

## Included Languages & Tools

- Node == 18.18.0
- nvm == 0.39.5
- npm == 9.8.1
- Java == 20.0.2
- Gradle == 8.3
- Maven == 3.8.7
- Dotnet == 6.0.122
- Python == 3.11.5
- Poetry == 1.1.13
- GO == 1.21.1

# Build Instructions

## Prerequisites

- You are running in a unix-like environment (Linux, MacOS)
- Docker Desktop

## Build

Builds the image.

```bash
make build
```

## Shell

Starts a container form this image and drops you into a shell.

```bash
make shell
```

## Publish

Attempts to build then publish the image to Docker Hub.

```bash
make publish
```
