include_recipe 'apt::default'
include_recipe 'apache2'
chef_gem 'htauth'

node['packages'].each do |pkgs| 
	package pkgs do 
		action :upgrade
	end
end

user node['icinga_sys']['user'] do 
	password node['icinga_sys']['password']
	action :create
end

group node['icinga_sys']['group'] do
	action :create
	append true
	members [node['icinga_sys']['user'], 'www-data']
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['icinga']['source']['package_name']}" do 
	source node['icinga']['package']
end

execute 'Untar icinga archive.' do 
	cwd Chef::Config[:file_cache_path]
	command "tar zxvf #{node['icinga']['source']['package_name']}"
end

# TODO: rewrite to use checkinstall.
execute "Build & install Icinga" do 
	cwd "#{Chef::Config[:file_cache_path]}/icinga-#{node['icinga']['source']['version']}"
	command "./configure --prefix=#{node['icinga']['root']} --enable-idoutils=no --with-command-group=icinga-cmd && make all && make fullinstall && make install-config"
end

directory "#{node['icinga']['root']}/var/rw" do 
	mode 0750
	recursive true
	only_if { setPassword? }
end

template node['icinga']['resource_cfg'] do
	source 'resource.cfg.erb'
	owner node['icinga_sys']['user']
	group node['icinga_sys']['user']

	variables(
		'plugins' => node['nagios_plugins']['root']
	)
	action :create
end 

template node['icinga']['cgi_cfg'] do 
	source 'cgi.cfg.erb'
	owner node['icinga_sys']['user']
	group node['icinga_sys']['user']

	variables(
		'username' => node['icingaadmin']['name'],
		'configuration_file' => node['icinga']['configuration']
	)
	action :create
end

apache_conf 'icinga' do 
	enable true
end

apache_module 'cgi' do
	enable true
	notifies :reload, "service['apache2']"
end

node['services'].each do |srv|
	service srv do
		supports :restart=>true, :start=>true, :stop=>true
		action [:enable, :restart]
	end
end 