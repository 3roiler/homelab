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

RUN curl -LO https://github.com/getsops/sops/releases/download/v3.11.0/sops-v3.11.0.linux.amd64 \
    && mv sops-v3.11.0.linux.amd64 /usr/local/bin/sops \
    && chmod +x /usr/local/bin/sops