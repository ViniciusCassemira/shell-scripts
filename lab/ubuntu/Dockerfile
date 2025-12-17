FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    git \
    nano \
    wget \
    && rm -rf /var/lib/apt/lists/*