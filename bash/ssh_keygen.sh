#!/bin/bash

# This script generates an SSH key in ed25519 format, bringing you the public and private key, being able to generate the private key in PEM format, in addition to being able to save the public key in your authorized_keys

SSH_PATH=~/.ssh
DEFAULT_NAME=key_auth

read -p "Type the description key (press Enter to use default): " KEY_DESC

if [[ -z "$KEY_DESC" ]]; then
    KEY_DESC="$DEFAULT_NAME"
fi

# Create key directory
mkdir -p "$SSH_PATH/$KEY_DESC"
chmod 700 "$SSH_PATH/$KEY_DESC"

# Generate SSH key pair
ssh-keygen -t ed25519 -f "$SSH_PATH/$KEY_DESC/id_ed25519" -N ""

touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

read -p "Would you like to add the public key to authorized_keys? (y/n): " responsePubKey

if [[ "$responsePubKey" == "y" || "$responsePubKey" == "Y" ]]; then
    cat "$SSH_PATH/$KEY_DESC/id_ed25519.pub" >> ~/.ssh/authorized_keys
    echo "The public key was successfully added to authorized_keys!"
elif [[ "$responsePubKey" == "n" || "$responsePubKey" == "N" ]]; then
    echo "The key will not be inserted in authorized_keys. You can do this later."
else
    echo "[DEFAULT ACTION] The key will not be inserted in authorized_keys. You can do this later."
fi

read -p "Would you like to generate a private key in PEM format? (y/n): " responsePemKey

if [[ "$responsePemKey" == "y" || "$responsePemKey" == "Y" ]]; then
    echo "PEM conversion is not supported for ed25519 keys."
    echo "If you need PEM format, generate an RSA key instead."
elif [[ "$responsePemKey" == "n" || "$responsePemKey" == "N" ]]; then
    echo "PEM format key has not been generated. You can do that later if needed."
else
    echo "[DEFAULT ACTION] PEM format key has not been generated. You can do that later if needed."
fi

echo "You can see the keys in: $SSH_PATH/$KEY_DESC"
ls -l "$SSH_PATH/$KEY_DESC"