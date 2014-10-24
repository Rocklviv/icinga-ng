include_recipe "checkinstall::default"

user node['icinga_sys']['user'] do
	password node['icinga_sys']['password']
	action :create
end

group node['icinga_sys']['group'] do
	action :create
	append true
	if platform_family?("debian")
		members [node['icinga_sys']['user'], 'www-data']
	elsif platform_family?("rhel")
		members [node['icinga_sys']['user'], 'apache']
	end
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['icinga']['source']['package_name']}" do
	source node['icinga']['package']
end

directory node['icinga']['root'] do
	owner node['icinga_sys']['user']
	group node['icinga_sys']['group']
	action :create
end

checkinstall_package 'icinga' do
	source_archive "#{Chef::Config[:file_cache_path]}/#{node['icinga']['source']['package_name']}"
	configure_options "--prefix=#{node['icinga']['root']} --exec-prefix=#{node['icinga']['root']} --enable-idoutils=#{node['icinga']['idoutils']} --with-command-group=#{node['icinga_sys']['group']} --with-gd-lib=/usr/local/include/"
	version node['icinga']['source']['version']
	binary_name "icinga"
	checkinstall true
	cmake false
	autoconf false
  autoheader false
  make true
  configure true
	make_options node['make']['options']
	if platform_family?('rhel')
		options '--exclude=/selinux'
	elsif platform_family?('debian')
		if platform?('debian')
			options '-D --install=no --fstrans=no --reset-uids=yes'
		end
	end
end

if platform_family?('debian')
	dpkg_package "#{Chef::Config[:file_cache_path]}/icinga-#{node['icinga']['source']['version']}/icinga_#{node['icinga']['source']['version']}-1_amd64.deb" do
		action :install
	end
elsif platform_family?('rhel')
	rpm_package "/root/rpmbuild/RPMS/x86_64/icinga-#{node['icinga']['source']['version']}-1.x86_64.rpm" do
		action :install
	end
end

directory "#{node['icinga']['root']}/var/rw" do
	owner node['icinga_sys']['user']
	group node['apache']['group']
	only_if { setPassword? }
end

execute "Permissions" do
	command "chmod g+sx #{node['icinga']['root']}/var/rw"
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
end

node['services'].each do |srv|
	service srv do
		supports :restart=>true, :start=>true, :stop=>true
		action [:enable, :restart]
	end
end
