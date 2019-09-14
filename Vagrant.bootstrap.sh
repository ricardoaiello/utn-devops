#!/bin/bash

sudo apt-get update -y ;

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common dos2unix linux-image-extra-$(uname -r) linux-image-extra-virtual

sudo mkdir -p /var/db/mysql

sudo mkdir /scripts

sudo mv -f /tmp/docker-stop.sh /scripts
sudo mv -f /tmp/docker-start.sh /scripts
sudo chmod 755 /scripts/*
sudo dos2unix /scripts/docker-start.sh
sudo dos2unix /scripts/docker-stop.sh

sudo mv -f /tmp/ufw /etc/default/ufw
sudo mv -f /tmp/etc_hosts.txt /etc/hosts

APP_ROOT="/var/www";
APP_PATH=$APP_ROOT . "/utn-devops-app";

sudo mkdir $APP_ROOT;
cd $APP_ROOT;
sudo git clone https://github.com/ricardoaiello/utn-devops-app-grupo1.git $APP_PATH;
cd $APP_PATH;
sudo git checkout unidad-2;


# Puppet #
wget https://apt.puppetlabs.com/puppet5-release-xenial.deb
sudo dpkg -i puppet5-release-xenial.deb
sudo apt update
sudo apt-get install -y puppet-lint puppetmaster
sudo apt-get install -y puppet 
sudo mv -f /tmp/puppet-master.conf /etc/puppet/puppet.conf
sudo rm -rf /var/lib/puppet/ssl
sudo usermod -a -G sudo,puppet puppet

# Docker #
sudo mkdir -p /etc/puppet/modules/docker_install/manifests
sudo mkdir /etc/puppet/modules/docker_install/files

# Jenkins #
sudo mkdir -p /etc/puppet/modules/jenkins/manifests
sudo mkdir /etc/puppet/modules/jenkins/files

# Puppet #
sudo mv -f /tmp/site.pp /etc/puppet/manifests/
sudo mv -f /tmp/init.pp /etc/puppet/modules/docker_install/manifests/init.pp
sudo mv -f /tmp/env /etc/puppet/modules/docker_install/files
sudo mv -f /tmp/init_jenkins.pp /etc/puppet/modules/jenkins/manifests/init.pp
sudo mv -f /tmp/jenkins_default /etc/puppet/modules/jenkins/files/jenkins_default
sudo mv -f /tmp/jenkins_init_d /etc/puppet/modules/jenkins/files/jenkins_init_d

sudo dos2unix /etc/puppet/modules/jenkins/files/jenkins_init_d

sudo service puppetmaster stop && service puppetmaster start

sudo puppet node clean utn-devops-grupo1
sudo puppet agent --certname utn-devops-grupo1 --enable
