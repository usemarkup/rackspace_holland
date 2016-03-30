name             'rackspace_holland'
maintainer       'Rackspace, US Inc.'
maintainer_email 'rackspace-cookbooks@rackspace.com'
license          'Apache 2.0'
description      'Installs/Configures rackspace_holland'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'openssl'
depends 'rackspace_mysql'
depends 'rackspace_build_essential'
