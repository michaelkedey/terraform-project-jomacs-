#!/bin/bash
#Author: michael_kedey
#Date: 19/10/2023
#Last_modified: 24/10/2023
#Purpose: install nginx and change the default ssh port
#Use_case: user file to run on boot after a new ec2 has been instantaited

sudo apt-get update
sudo apt-get upgrade -y

#install nginx and start the service
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

echo '<h1>Congrats! you have installed nginx</h1>' > /var/www/html/index.html

# Set up a reverse proxy in NGINX to forward requests to the  local server
# local_server="http://localhost:80"
# sudo rm /etc/nginx/sites-available/default  
# sudo tee /etc/nginx/sites-available/local_server.conf <<EOF
# server {
#     listen 80;

#     location / {
#         proxy_pass $local_server;
#         proxy_http_version 1.1;
#         proxy_set_header Upgrade \$http_upgrade;
#         proxy_set_header Connection 'upgrade';
#         proxy_set_header Host \$host;
#         proxy_cache_bypass \$http_upgrade;
#     }
# }
# EOF

# #create a link of the available site in the sites-enabled directory
# sudo ln -s /etc/nginx/sites-available/server.conf /etc/nginx/sites-enabled/

sudo systemctl restart nginx

# Change the SSH port to 273
new_port=273
sudo sed -i "s/^#Port 22/Port $new_port/" /etc/ssh/sshd_config
sudo systemctl restart sshd
