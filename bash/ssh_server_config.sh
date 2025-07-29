# This command will config /etc/ssh/sshd_config file to allow SSH key login, 
# unable login with password and other security configs
#!/bin/bash

#1. Format .ssh/
read -p "Antes de continuar, você deseja formatar o arquivo authorized_keys? (Y/N): " resetKeys

if [[ "$resetKeys" == "Y" || "$resetKeys" == "y" ]]; then
    echo "Vamos resetar as chaves."

    #Create key directory
    mkdir -p ~/.ssh/keys/
    chmod 700 ~/.ssh/keys/

    # Generate SSH key pair
    ssh-keygen -t ed25519 -f ~/.ssh/keys/id_ed25519 -N ""

    touch ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys

    cat ~/.ssh/keys/id_rsa.pub > ~/.ssh/authorized_keys
    echo "The public key was successfully added in authorized_keys!"

    chmod 600 ~/.ssh/keys/id_rsa
    openssl rsa -in ~/.ssh/keys/id_rsa -out ~/.ssh/keys/id_rsa_pem

    echo "You can see the keys in: ~/.ssh/keys/"
    ls -l ~/.ssh/keys/
else
    echo "Canceled Operation."
fi

#2. Config sshd

cat > /etc/ssh/sshd_config <<EOF
Port 22 
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM no
Protocol 2
AuthorizedKeysFile .ssh/authorized_keys
PermitEmptyPasswords no
LoginGraceTime 30
MaxAuthTries 2
LogLevel VERBOSE
EOF

# Restart ssh service to apply
systemctl restart sshd

echo "[OK] /etc/ssh/sshd_config updated and SSH service restarted."