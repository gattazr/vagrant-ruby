#
# Cookbook Name:: app
# Recipe:: ruby
#
# Copyright 2013, Rémi GATTAZ
#


# ensure the local APT package cache is up to date
include_recipe 'apt'
# install ruby_build tool which we will use to build ruby
include_recipe 'ruby_build'
	ruby_build_ruby '2.1.1' do
	prefix_path '/usr/local/'
	environment 'CFLAGS' => '-g -O2'
	action :install
end

node['ruby']['gems'].each do |wGem|
	gem_package wGem[:name] do
		version wGem[:version]
		gem_binary wGem[:gem_binary]
		options wGem[:options]
		end
	
end

#node['ruby']['gems'].each do |wGem|
#	if wGem.has_key?("name")
#		gem_package wGem[:name] do
#			wGem.each do |wKey, wValue|
#				send(wKey) wValue
#			end
#		end
#	end
#end


