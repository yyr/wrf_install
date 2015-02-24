# -*- mode: ruby -*-

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "trusty64", primary: true do |trusty64|
    # Every Vagrant virtual environment requires a box to build off of.
    trusty64.vm.box = "ubuntu/trusty64"
    trusty64.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    trusty64.vm.host_name = 'wrf'

    # config.ssh.forward_agent = true
    trusty64.vm.synced_folder ".", "/home/vagrant/wrf_install"

    trusty64.vm.provider :virtualbox do |vb|
      # vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    trusty64.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/vm.yml"
    end
  end

  config.vm.define "precise64", primary: true do |precise64|
    # Every Vagrant virtual environment requires a box to build off of.
    precise64.vm.box = "ubuntu/precise64"
    precise64.vm.box_url = "http://files.vagrantup.com/precise64.box"
    precise64.vm.host_name = 'wrf'

    # config.ssh.forward_agent = true
    precise64.vm.synced_folder ".", "/home/vagrant/wrf_install"

    precise64.vm.provider :virtualbox do |vb|
      # vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    precise64.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/vm.yml"
    end
  end

end
