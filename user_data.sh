#!/bin/bash

sudo dnf update

# Install Docker
sudo dnf install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
newgrp docker

# Install Rancher
docker run --name rancher-server -d --restart=unless-stopped -p 8080:80 -p 8443:443 --privileged rancher/rancher:v2.7.4 --no-cacerts
