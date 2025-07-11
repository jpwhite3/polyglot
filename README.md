![Docker](https://github.com/jpwhite3/polyglot/workflows/Docker/badge.svg)

# Polyglot

Multi programming language container image built for interactive development environments like:

- [Coder](https://coder.com)
- [GitHub Codespaces](https://github.com/features/codespaces)
- [JupyterLab](https://jupyter.org)
- [GitLab](https://about.gitlab.com)
- etc.

_NOTE:_ This image is **large**, around 5GB in total. This makes it far too big for most large scale uses. But in small scale it seems to work quite well despite its size.

## Base Image

This image is based on Ubuntu (latest LTS)

## Included Languages & Tools

| Language Ecosystem | Version | Included Tools       |
| ------------------ | ------- | -------------------- |
| Node               | 22.16.0 | nvm, npm             |
| Python             | 3.12.3 | poetry, pipenv, pipx |
| Java               | 21.0.7 |                      |
| Dotnet             | 8.0.117 |                      |
| GO                 | 1.24.4 |                      |
| Ruby               | 3.2.3 | rbenv, gem           |
| Rust               | 1.87.0 |                      |
| Docker             | 28.2.2 |                      |

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
