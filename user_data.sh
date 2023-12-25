#!/bin/bash

sudo apt-get update

# Install Docker
# sudo apt-get install ca-certificates curl gnupg -y
# sudo install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# sudo chmod a+r /etc/apt/keyrings/docker.gpg
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#   $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
#   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update
# VERSION_STRING=5:20.10.2~3-0~ubuntu-focal
# sudo apt-get install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin

# sudo systemctl start docker
# sudo systemctl enable docker
sudo snap install docker

sudo chmod 666 /var/run/docker.sock
sudo addgroup --system docker
sudo usermod -aG docker ubuntu
newgrp docker

# Start Rancher
docker run --name rancher -d --restart=unless-stopped -p 80:80 -p 443:443 \
  --privileged rancher/rancher:v2.7.4 --acme-domain rancher.ntnghia.click --debug
