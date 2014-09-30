set['apache']['default_site_enabled'] = true

# Icinga username and password
default['icingaadmin']['name'] = 'icingaadmin'
default['icingaadmin']['password'] = 'icingaadmin'

# System settings
default['packages'] = %w(apache2 build-essential mailutils libssl-dev openssl apache2-utils nagios-plugins)

# Icinga directories.
default['icinga']['root'] = '/opt/icinga'
default['icinga']['configuration'] = node['icinga']['root'] + '/etc/icinga.cfg'
default['icinga']['resource_cfg'] = node['icinga']['root'] + '/etc/resource.cfg'
default['icinga']['cgi_cfg'] = node['icinga']['root'] + '/etc/cgi.cfg'
default['icinga']['htpasswd'] = node['icinga']['root'] + '/etc/htpasswd.users'

default['icinga_sys']['user'] = 'icinga'
default['icinga_sys']['password'] = 'icinga'
default['icinga_sys']['group'] = 'icinga-cmd'
default['nagios_plugins']['root'] = '/usr/lib/nagios/plugins'

default['icinga']['source']['url'] = 'https://github.com/Icinga/icinga-core/releases/download/v'
default['icinga']['source']['version'] = '1.11.7'
default['icinga']['source']['package_name'] = "icinga-#{node['icinga']['source']['version']}.tar.gz"
default['icinga']['package'] = node['icinga']['source']['url'] + node['icinga']['source']['version'] + '/' + node['icinga']['source']['package_name']

# Services
if platform_family?('debian')
	default['services'] = %w(apache2 icinga)
else
	default['services'] = %w(httpd icinga)
end
