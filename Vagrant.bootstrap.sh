#!/bin/bash

### Software provisioning ###

# Updates
sudo apt-get updates

# Web server
sudo apt-get install -y apache2 


### Environment ###

## Swap partition
sudo mkdir /swapdir
cd /swapdir
sudo dd if=/dev/zero of=/swapdir/swapfile bs=1024 count=2000000
sudo mkswap -f  /swapdir/swapfile
sudo chmod 600 /swapdir/swapfile
sudo swapon swapfile
echo "/swapdir/swapfile       none    swap    sw      0       0" | sudo tee -a /etc/fstab /etc/fstab
sudo sysctl vm.swappiness=10
echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf


## Web server

# Root paths
APACHE_ROOT="/var/www";
APP_PATH="$APACHE_ROOT/utn-devops-app";

# VirtualHost configuration
if [ -f "/tmp/devops.site.conf" ]; then
	echo "Copy Apache VirtualHost configuration file";
	sudo mv /tmp/devops.site.conf /etc/apache2/sites-available
	sudo a2ensite devops.site.conf
	sudo a2dissite 000-default.conf
	sudo service apache2 reload
fi
	
# Application
if [ ! -d "$APP_PATH" ]; then
	echo "Clone repository";
	cd $APACHE_ROOT;
	sudo git clone https://github.com/ricardoaiello/utn-devops-app.git;
	cd $APP_PATH;
	sudo git checkout master;
fi

