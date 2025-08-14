max_key=4

while true; do
    read -p "How many projects do you want to configure? " numberProjects
    
    if [[ "$numberProjects" -lt $((max_key + 1)) ]] && [[ "$numberProjects" -gt 0 ]]; then
        echo "Configuring $numberProjects project(s)..."
        break
    else
        echo "Please choose a number between 1 and $max_key"
    fi
done

while true; do
    read -p "Out of $numberProjects projects, how many are on GitHub? " githubProjects
    if [[ "$githubProjects" -gt "$numberProjects" ]] || [[ "$githubProjects" -lt 0 ]]; then
        echo "Please enter a valid value."
    else
        gitlabProjects=$((numberProjects - githubProjects))
        echo "Summary:"
        echo "GitHub projects: $githubProjects"
        echo "GitLab projects: $gitlabProjects"
        
        read -p "Confirm configurations before starting? (y/N): " confirmProjects
        if [[ "${confirmProjects,,}" == "y" ]]; then
            clear
            echo "Configuring $numberProjects project(s)..."
            break
        else
            echo "Process canceled"
            exit 1
        fi
    fi
done

for ((i=1; i<=$githubProjects; i++)); do
    echo "GitHub project: $i"
    ssh-keygen -t ed25519 -f "$HOME/.ssh/github-proj$i" -N "" -q

    echo "Host github-proj$i
        HostName github.com
        User git
        IdentityFile ~/.ssh/github-proj$i" >> ~/.ssh/config

    echo "GitHub key #$i generated. Use the public key in your project's Deploy Keys:"
    cat ~/.ssh/github-proj$i.pub
done

for ((i=1; i<=$gitlabProjects; i++)); do
    echo "GitLab project: $i"
    ssh-keygen -t ed25519 -f "$HOME/.ssh/gitlab-proj$i" -N "" -q

    echo "Host gitlab-proj$i
        HostName gitlab.com
        User git
        IdentityFile ~/.ssh/gitlab-proj$i" >> ~/.ssh/config
    
    echo "GitLab key #$i generated. Use the public key in your project's Deploy Keys:"
    cat ~/.ssh/gitlab-proj$i.pub
done

echo "To git your project, use this syntax:"
echo "git clone git@gitlab-proj1:username/project1.git (or github)"
echo "[Example] - git clone git@gitlab-proj1:ViniciusCassemira/gitlab-ci-connect-server.git"
echo "If your project is already on the server, access it and run:"
echo "git remote set-url origin git@gitlab-proj1:username/project1.git"