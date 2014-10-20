# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "trusty64", primary: true do |trusty64|
    # Every Vagrant virtual environment requires a box to build off of.
    trusty64.vm.box = "ubuntu/trusty64"
    trusty64.vm.host_name = 'wrf'

    # config.ssh.forward_agent = true
    trusty64.vm.synced_folder ".", "/wrf_install"

    trusty64.vm.provider :virtualbox do |vb|
      # vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    trusty64.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/vm.yml"
    end
  end
end
