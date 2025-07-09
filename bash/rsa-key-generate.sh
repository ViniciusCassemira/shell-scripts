#!/bin/bash

# Environment variables for the script
PROJECT_NAME=test
KEY_NAME=key_auth
KEY_COMMENT="projeto-malconX"
KEY_DIR="$HOME/.ssh/$PROJECT_NAME"
KEY_PEM_NAME="${KEY_NAME}-pem"

# Create the key directory
mkdir -p "$KEY_DIR"
chmod 700 "$KEY_DIR"

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -f "$KEY_DIR/$KEY_NAME" -N "" -C "$KEY_COMMENT"

# Ensure authorized_keys file exists
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Append the public key to authorized_keys
cat "$KEY_DIR/$KEY_NAME.pub" >> ~/.ssh/authorized_keys

# Copy private key and convert to PEM format
cp "$KEY_DIR/$KEY_NAME" "$KEY_DIR/$KEY_PEM_NAME"
ssh-keygen -p -m PEM -f "$KEY_DIR/$KEY_PEM_NAME" -P "" -N ""

# Set permissions for .ssh directory and keys
chmod 700 ~/.ssh
chmod 600 "$KEY_DIR/$KEY_NAME"
chmod 600 "$KEY_DIR/$KEY_PEM_NAME"

echo "✅ SSH keys successfully generated in: $KEY_DIR"
