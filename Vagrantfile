Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.hostname = "grupo1.utn-devops.localhost"

  config.vm.provider "virtualbox" do |vb|
	vb.name = "utn-devops-grupo1"
    vb.memory = "1024"
  end

  config.vm.network "forwarded_port", guest: 8081, host: 8081
  config.vm.network "forwarded_port", guest: 4400, host: 4400

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "file", source: "config/site-devops.conf", destination: "/tmp/site-devops.conf"

  config.vm.provision "file", source: "hostConfigs/ufw", destination: "/tmp/"

  config.vm.provision :shell, path: "Vagrant.bootstrap.sh", run: "always"
end
