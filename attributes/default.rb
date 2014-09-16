# Debian family attributes.
default['icinga']['hostname'] = 'icinga-server'
default['hostname'] = node['icinga']['hostname'] ? node['icinga']['hostname'] : node['hostname']


if platform_family?("debian")
	if platform?('ubuntu')
		if node['platform_version'] >= '14.04'
			default['packages'] = %w(software-properties-common icinga)
		else
			default['packages'] = %w(python-software-properties icinga)
		end
	end
end
#