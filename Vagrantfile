# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "wrf_install", primary: true do |wrf_install|
    # Every Vagrant virtual environment requires a box to build off of.
    wrf_install.vm.box = "ubuntu/trusty64"
    wrf_install.vm.host_name = 'wrf'

    # config.ssh.forward_agent = true
    wrf_install.vm.synced_folder ".", "/wrf_install"

    wrf_install.vm.provider :virtualbox do |vb|
      # vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    wrf_install.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/vm.yml"
    end
  end
end
