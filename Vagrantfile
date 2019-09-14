Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.hostname = "grupo1.utn-devops.localhost"

  config.vm.provider "virtualbox" do |vb|
	vb.name = "utn-devops-grupo1"
    vb.memory = "1024"
  end

  config.vm.network "forwarded_port", guest: 8081, host: 8081
  config.vm.network "forwarded_port", guest: 8082, host: 8082
  config.vm.network "forwarded_port", guest: 4400, host: 4400
  config.vm.network "forwarded_port", guest: 8140, host: 8140

  config.vm.provision "file", source: "hostConfigs/ufw", destination: "/tmp/utw"
  config.vm.provision "file", source: "hostConfigs/etc_hosts.txt", destination: "/tmp/etc_hosts.txt"

  config.vm.provision "file", source: "hostConfigs/puppet/site.pp", destination: "/tmp/site.pp"
  config.vm.provision "file", source: "hostConfigs/puppet/init.pp", destination: "/tmp/init.pp"
  config.vm.provision "file", source: "hostConfigs/puppet/init_jenkins.pp", destination: "/tmp/init_jenkins.pp"
  config.vm.provision "file", source: "hostConfigs/puppet/puppet-master.conf", destination: "/tmp/puppet-master.conf"
  config.vm.provision "file", source: "hostConfigs/puppet/.env", destination: "/tmp/env"

  config.vm.provision "file", source: "hostConfigs/jenkins/default_jenkins", destination: "/tmp/jenkins_default"
  config.vm.provision "file", source: "hostConfigs/jenkins/init_d", destination: "/tmp/jenkins_init_d"

  config.vm.provision "file", source: "hostConfigs/docker-start.sh", destination: "/tmp/docker-start.sh"
  config.vm.provision "file", source: "hostConfigs/docker-stop.sh", destination: "/tmp/docker-stop.sh"
  
  config.vm.provision :shell, path: "Vagrant.bootstrap.sh"
end
