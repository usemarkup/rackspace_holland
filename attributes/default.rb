#
# Cookbook Name:: rackspace_holland
# Attributes:: default
#
# Copyright 2014, Rackspace, US Inc.
#

secure_password = '2081D6F9-4CC0-4186-A5A1-139F521B8ABB'

set_unless['rackspace_holland']['server_holland_password'] = secure_password
default['rackspace_holland']['dir'] = '/var/lib/mysqlbackup'
default['rackspace_holland']['ver'] = '1.0.10-1'

default['rackspace_holland']['install']['container'] = 'https://4230a9a8f32809683bca-52dba99d4950464d3fae008a2694a6e5.ssl.cf5.rackcdn.com'

case node['platform']
when 'debian'
  case node['platform_version']
  when '7.2'
    default['rackspace_holland']['install']['main'] = 'debian72-holland_1.0.10-1_all.deb'
    default['rackspace_holland']['install']['common'] = 'debian72-holland-common_1.0.10-1_all.deb'
    default['rackspace_holland']['install']['mysqldump'] = 'debian72-holland-mysqldump_1.0.10-1_all.deb'
  end
when 'ubuntu'
  case node['platform_version']
  when '12.04'
    default['rackspace_holland']['install']['main'] = 'ubuntu1204-holland_1.0.10-1_all.deb'
    default['rackspace_holland']['install']['common'] = 'ubuntu1204-holland-common_1.0.10-1_all.deb'
    default['rackspace_holland']['install']['mysqldump'] = 'ubuntu1204-holland-mysqldump_1.0.10-1_all.deb'
  end
end
