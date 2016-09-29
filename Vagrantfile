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

      nomad.vm.provision :ansible do |ansible|
        ansible.verbose = "v"
        ansible.playbook = "nomad.yml"
        ansible.extra_vars = {
          current_ip: "192.168.10.1#{i}",
          nomad_node_name: "nomad-#{i}",
          consul_node_name: "consul-#{i}",
        }
      end
    end
  end

  4.upto(6) do |i|
    config.vm.define "nomad#{i}" do |nomadclient|
      nomadclient.vm.box = "centos/7"
      nomadclient.vm.network "private_network", ip: "192.168.10.1#{i}"

      nomadclient.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end

      nomadclient.vm.provision :ansible do |ansible|
        ansible.verbose = "v"
        ansible.playbook = "nomad.yml"
        ansible.extra_vars = {
          current_ip: "192.168.10.1#{i}",
          nomad_client: true,
          nomad_server: false,
          nomad_node_name: "nomad-#{i}",
          consul_node_name: "consul-#{i}",
        }
      end
    end
  end
end
