#!/bin/bash

### Software provisioning ###

# Updates
sudo apt-get update -y

# Web server
sudo apt-get remove --purge apache2 -y; 
sudo apt autoremove -y;

# Database server
sudo mkdir -p /var/db/mysql

# Firewall
sudo mv -f /tmp/ufw /etc/default/ufw


### Environment ###

## Swap partition
sudo swapon /swapdir/swapfile
echo "/swapdir/swapfile       none    swap    sw      0       0" | sudo tee -a /etc/fstab /etc/fstab
sudo sysctl vm.swappiness=10
echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf

# Root paths
APACHE_ROOT="/var/www";
APP_PATH="$APACHE_ROOT/utn-devops-app";

# Application
cd $APACHE_ROOT;
sudo git clone https://github.com/Fichen/utn-devops-app.git;
cd $APP_PATH;
sudo git checkout unidad-2;

# Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common ;
curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" > /tmp/docker_gpg;
sudo apt-key add < /tmp/docker_gpg && sudo rm -f /tmp/docker_gpg;
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";
sudo apt-get update -y ;
sudo apt-get install -y docker-ce docker-compose
sudo systemctl enable docker
