#!/bin/bash

while getopts d: flag
do
    case "${flag}" in
        d) workdir=${OPTARG};;
    esac
done

workdir=${workdir:-application}

sudo apt update -qq && sudo apt upgrade -y -qq --no-install-recommends --exclude=linux-generic,linux-headers-generic,linux-image-generic
sudo apt install nginx -y

sudo ufw allow 'Nginx HTTP'
sudo systemctl restart nginx

server_ip=$(curl -4 icanhazip.com)

sudo mkdir -p /var/www/$workdir/
sudo chown -R $USER:$USER /var/www/$workdir/
sudo chmod -R 755 /var/www/$workdir/

cat <<EOF | sudo tee /var/www/$workdir/index.html > /dev/null
<html>
  <head>
    <title>Welcome to your app</title>
  </head>
  <body>
    <h1>Success!</h1>
  </body>
</html>
EOF

cat <<EOF | sudo tee /etc/nginx/sites-available/$workdir > /dev/null
server {
  listen 80;
  listen [::]:80;

  root /var/www/$workdir/;
  index index.html index.htm index.nginx-debian.html;

  server_name $server_ip www.$server_ip;

  location / {
    try_files \$uri \$uri/ =404;
  }
}
EOF

sudo ln -s /etc/nginx/sites-available/$workdir /etc/nginx/sites-enabled/

sudo nginx -t && sudo systemctl restart nginx

echo "Your web-service can be accessed at: http://$server_ip"