# -*- mode: ruby -*-
# vi: set ft=ruby :

NB_MONITORS = "1"
NB_CPUS = 6
MEMORY = "8192"
VRAM = "64"
#SYSTEM_DISK_SIZE = "20GB"

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  unless Vagrant.has_plugin?("vagrant-disksize")
    raise 'You must install the vagrant-disksize plugin. install using: vagrant plugin install vagrant-disksize'
  end

  # TODO: create a new /home directory with the ~40G extra
  #config.disksize.size = SYSTEM_DISK_SIZE


  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    vb.name = "devbox-arch"

    # resources
    vb.memory = MEMORY
    vb.customize ["modifyvm", :id, "--cpus", NB_CPUS]

    # graphics
    vb.customize ["modifyvm", :id, "--monitorcount", NB_MONITORS]
    vb.customize ["modifyvm", :id, "--vram", VRAM]
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    #none|vboxvga|vmsvga|vboxsvga
    vb.customize ["modifyvm", :id, "--accelerate3d", "off"]

    # Customise audio
    vb.customize ["modifyvm", :id, "--audioout", "on"]
    vb.customize ["modifyvm", :id, "--audio", "dsound"]
    vb.customize ["modifyvm", :id, "--audiocontroller", "hda"]

    vb.customize ['modifyvm', :id, '--clipboard-mode', 'bidirectional']

  end

  # mount my Users\<>\src folder on host to /home/vagrant/src
  config.vm.synced_folder ENV['USERPROFILE'] + "/src", "/home/vagrant/src"
end
