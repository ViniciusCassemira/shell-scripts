#!/bin/bash

SSH_PATH=~/.ssh
DEFAULT_NAME=key_auth

read -p "Type the description key (press Enter to use default): " KEY_DESC

if [[ -z "$KEY_DESC" ]]; then
    KEY_DESC="$DEFAULT_NAME"
fi

#Create key directory
mkdir -p "$SSH_PATH/$KEY_DESC"
chmod 770 "$SSH_PATH/$KEY_DESC"

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -m PEM -f "$SSH_PATH/$KEY_DESC/id_rsa" -N ""

touch ~/.ssh/authorized_keys
chmod 666 ~/.ssh/authorized_keys

read -p "Yout would to add public key to authorized_keys? (y/n): " responsePubKey

if [[ "$responsePubKey" == "y" || "$responsePubKey" == "Y" ]]; then
    cat "$SSH_PATH/$KEY_DESC/id_rsa.pub" >> ~/.ssh/authorized_keys
    echo "The public key was successfully added in authorized_keys!"

elif [[ "$responsePubKey" == "n" || "$responsePubKey" == "N" ]]; then
    echo "The key will not be inserted in the authorized_keys. You can do this later."

else
    echo "[DEFAULT ACTION] The key will not be inserted in the authorized_keys. You can do this later."

fi

read -p "Yout would to generate other private key in PEM format? (y/n): " responsePemKey

if [[ "$responsePemKey" == "y" || "$responsePemKey" == "Y" ]]; then
    chmod 644 "$SSH_PATH/$KEY_DESC/id_rsa"
    ls -l "$SSH_PATH/$KEY_DESC"
    openssl rsa -in "$SSH_PATH/$KEY_DESC/id_rsa" -out "$SSH_PATH/$KEY_DESC/id_rsa_pem"

elif [[ "$responsePemKey" == "n" || "$responsePemKey" == "N" ]]; then
    echo "The key in PEM format has not been generated, you can do that later."

else
    echo "[DEFAULT ACTION] The key in PEM format has not been generated, you can do that later."

fi

echo "You can see the keys in: $SSH_PATH/$KEY_DESC"
ls -l "$SSH_PATH/$KEY_DESC"