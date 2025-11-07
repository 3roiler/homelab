FROM mcr.microsoft.com/vscode/devcontainers/base:debian-12

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    wget \
    zip \
    jq \
    zsh \
    && rm -rf /var/lib/apt/lists/*