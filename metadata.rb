name             'icinga'
maintainer       'Denis Chekirda'
maintainer_email 'dchekirda@gmail.com'
license          'All rights reserved'
description      'Installs/Configures icinga server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

depends 'apt'
depends 'apache2'

%w('ubuntu debian').each do |os|
  supports (os)
end