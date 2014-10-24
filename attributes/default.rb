set['apache']['default_site_enabled'] = true

# Icinga username and password
default['icingaadmin']['name'] = 'icingaadmin'
default['icingaadmin']['password'] = 'icingaadmin'

# Icinga directories.
default['icinga']['root'] = '/opt/icinga'
default['icinga']['configuration'] = node['icinga']['root'] + '/etc/icinga.cfg'
default['icinga']['resource_cfg'] = node['icinga']['root'] + '/etc/resource.cfg'
default['icinga']['cgi_cfg'] = node['icinga']['root'] + '/etc/cgi.cfg'
default['icinga']['htpasswd'] = node['icinga']['root'] + '/etc/htpasswd.users'

# System settings
if platform_family?('debian')
	default['packages'] = %w(build-essential mailutils libssl-dev openssl nagios-plugins libgd2-xpm-dev)
elsif platform_family?('rhel')
  default['packages'] = %w(mailx openssl openssl-devel gcc gcc-c++ make kernel-devel nagios-plugins-all gd gd-devel)
end

default['make']['options'] = "all cgis install-init install-config install-commandmode install-cgis"

# System users for icinga.
default['icinga_sys']['user'] = 'icinga'
default['icinga_sys']['password'] = 'icinga'
default['icinga_sys']['group'] = 'icinga-cmd'

# Nagios plugins.
if platform_family?('debian')
	default['nagios_plugins']['root'] = '/usr/lib/nagios/plugins'
elsif platform_family?('rhel')
	default['nagios_plugins']['root'] = '/usr/lib64/nagios/plugins'
end

# Icinga source.
default['icinga']['source']['url'] = 'https://github.com/Icinga/icinga-core/releases/download/v'
default['icinga']['source']['version'] = '1.11.7'
default['icinga']['source']['package_name'] = "icinga-#{node['icinga']['source']['version']}.tar.gz"
default['icinga']['package'] = node['icinga']['source']['url'] + node['icinga']['source']['version'] + '/' + node['icinga']['source']['package_name']

# Services
if platform_family?('debian')
	default['services'] = %w(apache2 icinga)
elsif platform_family?('rhel')
	default['services'] = %w(httpd icinga)
end
