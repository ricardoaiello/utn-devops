Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.hostname = "grupo1.utn-devops.localhost"

  config.vm.provider "virtualbox" do |vb|
	vb.name = "utn-devops-grupo1"
  end

  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "file", source: "config/site-devops.conf", destination: "/tmp/site-devops.conf"

  config.vm.provision :shell, path: "Vagrant.bootstrap.sh", run: "always"
end
