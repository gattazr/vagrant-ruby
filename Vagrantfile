# -*- mode: ruby -*-
# vi: set ft=ruby :

# General configuration
#######################
require './config/general.rb'
require './config/database.rb'
require './config/ruby.rb'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# All Vagrant configuration is done here. The most common configuration
	# options are documented and commented below. For a complete reference,
	# please see the online documentation at vagrantup.com.

	# Every Vagrant virtual environment requires a box to build off of.
	config.vm.box = "precise32"
	config.vm.box_url = "http://files.vagrantup.com/precise32.box"

	# Enable Berkshelf support
	config.berkshelf.enabled = true

	# make sure omnibus is up to date
	config.omnibus.chef_version = :latest

	# set the name of the vm in virtualbox
	config.vm.provider :virtualbox do |vb|
		vb.name = "Vagrant-"+ App::Project_name
	end
	config.vm.boot_timeout = 120

	# set the shared folder
	config.vm.synced_folder "./public/" , App::Src_path, :mount_options => ["dmode=777", "fmode=666"]

	# update the apt repository
	config.vm.provision :shell, :inline => "apt-get update -qq"

	# Manage the adress and hostname of the VM
	config.vm.network :private_network, ip: App::Ip_address
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = true
	config.vm.define App::Project_name do |node|
		node.vm.hostname = App::Project_name + ".dev"
		node.vm.network :private_network, ip: App::Ip_address
		node.hostmanager.aliases = [ "www." + App::Project_name + ".dev" ]
	end
	config.vm.provision :hostmanager

	# Enable and configure chef solo
	config.vm.provision :chef_solo do |chef|
		chef.custom_config_path = "Vagrantfile.chef"
		# add the recipes
		chef.add_recipe "vagrant-ruby::ruby"
		chef.add_recipe "vagrant-ruby::database"

		chef.json = {
			:app => {
				:database_name => Database::Database_name,
				:database_user => Database::Database_user,
				:database_password => Database::Database_password,
				:database_dump => "/vagrant/config/"+Database::Database_dump
			},
			:ruby => {
				:version => Ruby::Version,
				:gems => Ruby::Gems
			},
			:mysql => {
				:host => 'localhost',
				:server_root_password   => Database::Root_password,
				:server_repl_password   => Database::Root_password,
				:server_debian_password => Database::Root_password,
				:bind_address           => App::Ip_address,
				:allow_remote_root      => true
			}
		}
	end
end
