# -*- mode: ruby -*-
# vi: set ft=ruby :

# Optional
hostUsername = ""
hostPassword = ""

vmName = ""
vmSharedFolderPath = "./#{vmName}"

homeFolder = "/home/vagrant/"

require 'fileutils'
FileUtils::mkdir_p vmSharedFolderPath


# Optional, see last provision
required_plugins = %w( vagrant-reload ) #vagrant-vbguest )
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin} && vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.

  config.vm.box = "kaorimatz/ubuntu-16.04-amd64"
  config.vm.hostname = vmName
  
  #config.vbguest.auto_update = true

  # In case of vb guest additions problem use:
  # vagrant plugin install vagrant-vbguest

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  config.vm.synced_folder ".", "/provision", type: "smb", smb_username: hostUsername, smb_password: hostPassword
  config.vm.synced_folder vmSharedFolderPath, "/#{vmName}", type: "smb", smb_username: hostUsername, smb_password: hostPassword

  # Provider
  config.vm.provider :virtualbox do |vb|
	vb.name = vmName
	vb.gui = true
    vb.cpus   = 4
    vb.memory = 4096

    #vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    #vb.customize ["modifyvm", :id, "--vram", "256"]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Timezone
  require 'time'
  offset = ((Time.zone_offset(Time.now.zone) / 60) / 60)

  #Had to hack that crap 'cause tzdata sucks and thinks GMT-4 is GMT+4
  #https://bugs.launchpad.net/ubuntu/+source/tzdata/+bug/1448565
  #Read and LÅL
  offset = -1 * offset
  #End of disgusting hack

  timezone_suffix = offset >= 0 ? "+#{offset.to_s}" : "#{offset.to_s}"
  timezone = 'Etc/GMT' + timezone_suffix
  config.vm.provision :shell, :inline => "echo \"#{timezone}\" | sudo tee /etc/timezone && rm -f /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata", run: "always"

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

  config.vm.provision "shell", inline: "apt-get update"
  config.vm.provision "shell", path: "./dotfiles_setup.sh", args: ["/provision", homeFolder, "vagrant"]
  config.vm.provision "shell", path: "./system_setup.sh", args: ["/provision", homeFolder, "vagrant"]
  config.vm.provision "shell", path: "./tools_setup.sh", args: [homeFolder, "vagrant"]
  config.vm.provision "shell", path: "./fonts_setup.sh", args: [homeFolder, "vagrant"]
  config.vm.provision "shell", path: "./vim_setup.sh", args: [homeFolder, "vagrant"]
  config.vm.provision "shell", path: "./zsh_setup.sh", args: [homeFolder, "vagrant"]
  
  # Optional
  # Reload after first provisioning to get Windowmanager-autostart
  config.vm.provision :reload

end
