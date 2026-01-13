#!/bin/bash -e

SSH_PATH=~/.ssh
DEFAULT_NAME=key_auth

read -p "Type the description key (press Enter to use default): " KEY_DESC

if [[ -z "$KEY_DESC" ]]; then
    KEY_DESC="$DEFAULT_NAME"
fi

# Create key directory
mkdir -p "$SSH_PATH/$KEY_DESC"
chmod 700 "$SSH_PATH/$KEY_DESC"

# RSA or Ed25519
ALG_CHOICE="0"
while [[ $ALG_CHOICE != "1" && $ALG_CHOICE != "2" ]];
do
echo "In which algorithm do you want to generate the key?"
echo "1) ed25519"
echo "2) rsa"
read -p "Your choice : " ALG_CHOICE

clear
done

# Determine generated key name
if [[ $ALG_CHOICE == "1" ]]; then
    GENERATED_KEY_NAME="id_ed25519"
else
    GENERATED_KEY_NAME="id_rsa"
fi

echo "Your choice: $ALG_CHOICE - $GENERATED_KEY_NAME"

# Generate keys based on user choice
if [[ $ALG_CHOICE == "1" ]]; then
    # Generate ed25519 key pair
    ssh-keygen -t ed25519 -f "$SSH_PATH/$KEY_DESC/$GENERATED_KEY_NAME" -N ""
else
    # Generate RSA key pair
    ssh-keygen -t rsa -b 4096 -f "$SSH_PATH/$KEY_DESC/$GENERATED_KEY_NAME" -N ""
fi

# PEM format option for RSA keys
if [[ $ALG_CHOICE == "2" ]]; then
    cp $SSH_PATH/$KEY_DESC/$GENERATED_KEY_NAME "$SSH_PATH/$KEY_DESC/$GENERATED_KEY_NAME.pem"
    ssh-keygen -p -m PEM -f "$SSH_PATH/$KEY_DESC/$GENERATED_KEY_NAME.pem" -P "" -N ""
    echo "- The private key in PEM format was created successfully."
fi

# Add public key to authorized_keys
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

read -p "- Would you like to add the public key to authorized_keys? (y/n): " responsePubKey

if [[ "$responsePubKey" == "y" || "$responsePubKey" == "Y" ]]; then
    cat "$SSH_PATH/$KEY_DESC/$GENERATED_KEY_NAME.pub" >> ~/.ssh/authorized_keys
    echo "- The public key was successfully added to authorized_keys!"
elif [[ "$responsePubKey" == "n" || "$responsePubKey" == "N" ]]; then
    echo "- The key will not be inserted in authorized_keys. You can do this later."
else
    echo "- [DEFAULT ACTION] The key will not be inserted in authorized_keys. You can do this later."
fi

# Final message
echo "- You can see the keys in: $SSH_PATH/$KEY_DESC"
ls -l "$SSH_PATH/$KEY_DESC"