# Sets username and password in htpasswd.users
def setPassword?
	require 'htauth'
	HTAuth::PasswdFile.open(node['icinga']['htpasswd'], HTAuth::File::CREATE) do |htfile|
		htfile.add_or_update(node['icingaadmin']['name'], node['icingaadmin']['password'], "sha1")
	end
end
