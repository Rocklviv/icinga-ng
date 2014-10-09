#
# Cookbook Name:: icinga-ng
# Recipe:: default
#
# Copyright (C) 2014 Denis Chekirda
#
# All rights reserved - Do Not Redistribute
#

if platform_family?("debian")
	include_recipe "icinga-ng::debian"
elsif platform_family?("rhel")
	include_recipe "icinga-ng::rhel"
end
