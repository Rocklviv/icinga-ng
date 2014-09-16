include_recipe 'apt::default'

package 'icinga' do
	action :upgrade
end

template '/etc/icinga/htpasswd.users' do 
	source 'htpasswd.users.erb'
	action :create
end