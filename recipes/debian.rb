include_recipe 'apt::default'
include_recipe 'apache2'
chef_gem 'htauth'

node['packages'].each do |pkgs|
	package pkgs do
		action :install
	end
end

include_recipe "icinga-ng::common"
