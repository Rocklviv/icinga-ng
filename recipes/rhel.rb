#
# Cookbook Name:: icinga-ng
# Recipe:: rhel
#
# Copyright (C) 2014 Denis Chekirda
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'yum::default'
include_recipe 'apache2'
chef_gem 'htauth'

yum_repository 'epel' do
  description 'Extra Packages for Enterprise Linux'
  mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
  gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
  action :create
end

node['packages'].each do |pkgs| 
	package pkgs do
		action :upgrade
	end
end

include_recipe "icinga-ng::common"