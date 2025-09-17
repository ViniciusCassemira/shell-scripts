#!/bin/bash

# This script will install and configure Docker and docker compose using official URL

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Testing installation
if docker compose -v &> /dev/null; then
  echo "docker installed successfully"
else
  echo "docker not installed"
  exit 1
fi

sudo groupadd docker
sudo usermod -aG docker $USER

sudo chown $USER:$USER /home/$USER/.docker -R
sudo chmod g+rwx $HOME/.docker -R

sudo apt update
sudo apt install -y docker-compose-plugin

# Testing installation
if docker compose -v &> /dev/null; then
  echo "docker compose installed successfully"
else
  echo "docker compose not installed"
  exit 1
fi