#!/bin/bash

#environment variables for the script
PROJECT_NAME=test
KEY_NAME=key_auth
KEY_COMMENT=projeto-malconX
KEY_DIR=~/.ssh/$PROJECT_NAME
KEY_PEM_NAME="${KEY_NAME}-pem"

mkdir -p "$KEY_DIR"

#Generate key
ssh-keygen -t rsa -b 4096 -f $KEY_DIR/$KEY_NAME -N "" -C $KEY_COMMENT

#Add public key authorized_keys file
cat $KEY_DIR/$KEY_NAME.pub >> ~/.ssh/authorized_keys

#converts private key from OPENSSH to PEM format
cp "$KEY_DIR/$KEY_NAME" "$KEY_DIR/$KEY_PEM_NAME"
ssh-keygen -p -m PEM -f $KEY_DIR/$KEY_PEM_NAME -P "" -N ""

# Permission ssh path and private key
chmod 700 ~/.ssh
chmod 600 ~/.ssh/$KEY_NAME

# echo "Key generated successfully"
# echo "Run 'cat ${KEY_DIR}/${KEY_NAME}.pub' to see your public key"
# echo "Run 'cat ${KEY_DIR}/${KEY_NAME}' to see your private key | [ sensitive key, be careful ]"