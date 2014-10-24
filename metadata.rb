name             'icinga-ng'
maintainer       'Denis Chekirda'
maintainer_email 'dchekirda@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures icinga v1 server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.7'

depends 'apt'
depends 'apache2'
depends 'yum'
depends 'checkinstall'

# Supported systems
supports 'debian'
supports 'ubuntu'
supports 'redhat'
supports 'centos'
