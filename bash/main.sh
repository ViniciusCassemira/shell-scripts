#!/bin/bash

# This script executes each setup script in this directory to configure the environment in a simple way.
# It's an alternative to using Ansible for basic provisioning.

# Update system
chmod +x system-auto-update.sh
bash system-auto-update.sh

# SSH Key generation
chmod +x ssh-keygen.sh
bash ssh-keygen.sh

# Docker and Docker Compose install
chmod +x docker-setup.sh
bash docker-setup.sh

# Nginx install and setup
chmod +x nginx-setup.sh
bash nginx-setup.sh