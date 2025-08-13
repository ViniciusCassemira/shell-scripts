# Generate keys
ssh-keygen -t ed25519 -f "~/.ssh/gitlab-proj1" -N ""
ssh-keygen -t ed25519 -f "~/.ssh/gitlab-proj2" -N ""
echo "Keys generated successfully"

# Config ~/.ssh/config file
echo "Host gitlab-proj1
 HostName gitlab.com
 User git
 IdentityFile ~/.ssh/gitlab-proj1
Host gitlab-proj2
 HostName gitlab.com
 User git
 IdentityFile ~/.ssh/gitlab-proj2" > ~/.ssh/config
echo "~/.ssh/config configured successfully:"
cat ~/.ssh/config

# Displaying public keys that were generated
echo "Use these keys to configure your Deploy keys in GitLab project"
echo "Proj1 .pub key"
cat ~/.ssh/gitlab-proj1.pub
echo "Proj2 .pub key"
cat ~/.ssh/gitlab-proj2.pub

echo "To git yout project, use this syntax:"
echo "git clone git@gitlab-proj1:username/project1.git"
echo "[Example] - git clone git@gitlab-proj1:ViniciusCassemira/gitlab-ci-connect-server.git"