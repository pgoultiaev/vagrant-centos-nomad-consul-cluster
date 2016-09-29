# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  1.upto(3) do |i|
    config.vm.define "nomad#{i}" do |nomad|
      nomad.vm.box = "centos/7"
      nomad.vm.network "private_network", ip: "192.168.10.1#{i}"

      nomad.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end

      nomad.vm.synced_folder ".", "/vagrant"
    end
  end
end
