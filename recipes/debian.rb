include_recipe 'apt::default'

package 'icinga' do
	action :upgrade
end

execute 'Create admin password' do 
	command "htpasswd -cb /etc/icinga/htpasswd.users #{node['icingaadmin']['name']} #{node['icingaadmin']['password']}"
	action :run
end

template '/etc/icinga/cgi.cfg' do 
	source 'cgi.cfg.erb'
	variables(
		'username' => node['icingaadmin']['name']
	)
	action :create
end