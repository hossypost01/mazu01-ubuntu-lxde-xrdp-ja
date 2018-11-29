Vagrant.configure(2) do |config|
  config.vm.box = "ailispaw/barge"   # hostOS in docker 14MB
  #config.vm.box = "ubuntu/trusty64" #
  config.vm.hostname = "lxde1"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "lxde1"
    vb.gui = false
    vb.memory = 4096
    vb.cpus = 4
    vb.customize [
      "modifyvm", :id,
      "--nicpromisc2","allow-all",
      "--vram", "256",
    ]
  end
  config.vm.network "private_network", ip: "192.168.33.12"
  #config.vm.provision "docker"
end
