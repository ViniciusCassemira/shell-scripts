FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    git \
    nano \
    sudo \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash "vinicius" && \
    echo "vinicius:123456" | chpasswd && \
    usermod -aG sudo "vinicius"

WORKDIR /home/vinicius
RUN git clone https://github.com/ViniciusCassemira/shell-scripts.git && \
    chown -R vinicius:vinicius /home/vinicius/shell-scripts && \
    chmod -R +x /home/vinicius/shell-scripts

USER vinicius