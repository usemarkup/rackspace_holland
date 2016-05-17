#
# Cookbook Name:: rackspace_holland
# Attributes:: default
#
# Copyright 2014, Rackspace, US Inc.
#

set_unless['rackspace_mysql']['server_debian_password'] = '79FDCADF-5D4A-4EFC-9683-8CC6DC5DF055'
set_unless['rackspace_mysql']['server_root_password'] = '79FDCADF-5D4A-4EFC-9683-8CC6DC5DF055'
set_unless['rackspace_mysql']['server_repl_password'] = '9048764A-F005-4406-BEBE-C524B58DC9B2'

secure_password = '2081D6F9-4CC0-4186-A5A1-139F521B8ABB'

set_unless['rackspace_holland']['server_holland_password'] = secure_password
default['rackspace_holland']['dir'] = '/var/lib/mysqlbackup'

default['rackspace_holland']['rhel_ver'] = '1.0.12-4.el6'

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

default['rackspace_holland']['templates_cookbook']['default.conf'] = 'rackspace_holland'
default['rackspace_holland']['templates_cookbook']['holland.conf'] = 'rackspace_holland'
default['rackspace_holland']['templates_cookbook']['holland.cron'] = 'rackspace_holland'
default['rackspace_holland']['templates_cookbook']['holland.sql'] = 'rackspace_holland'


# backupsets/default.conf.erb common attributes - reconfigure for your own set of backups
# 
# default['rackspace_holland']['backupsets']['name_of_backupset']['user'] = 'root'
# default['rackspace_holland']['backupsets']['name_of_backupset']['password'] = ''
# default['rackspace_holland']['backupsets']['name_of_backupset']['host'] = 'localhost'
# default['rackspace_holland']['backupsets']['name_of_backupset']['port'] = '3360'
# default['rackspace_holland']['backupsets']['name_of_backupset']['database'] = 'database_name'

# backupsets/default.conf.erb common attributes
default['rackspace_holland']['config']['holland']['keep'] = '7'
default['rackspace_holland']['config']['holland']['auto_purge_failures'] = 'yes'
default['rackspace_holland']['config']['holland']['purge_policy'] = 'after-backup'
default['rackspace_holland']['config']['holland']['estimated_size_factor'] = '1.0'
default['rackspace_holland']['config']['mysqldump']['file_per_database'] = 'yes'
default['rackspace_holland']['config']['mysqldump']['lock_method'] = 'auto-detect'
default['rackspace_holland']['config']['compression']['method'] = 'gzip'
default['rackspace_holland']['config']['compression']['options'] = '--rsyncable'

# holland.conf.erb attributes
default['rackspace_holland']['config']['holland.conf']['logging']['log_file'] = '/var/log/holland/holland.log'
## debug, info, warning, error, critical (case insensitive)
default['rackspace_holland']['config']['holland.conf']['logging']['level'] = 'info'
## the time the crontab should run
default['rackspace_holland']['config']['cron_time'] = '1 1 * * *'
