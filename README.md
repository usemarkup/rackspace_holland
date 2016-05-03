rackspace_holland Cookbook
==========================

Installs and configures Holland.
Currently only Holland's `mysqldump` plugin is supported.

Requirements
------------
#### cookbooks
`openssl`, `rackspace_mysql`, `rackspace_build_essential`

See [metadata.rb]('https://github.com/rackspace-cookbooks/rackspace_holland/blob/master/metadata.rb') for specific requirements.

Attributes
----------
See the [attributes/default.rb](https://github.com/rackspace-cookbooks/rackspace_holland/blob/master/attributes/default.rb) for default values.

Main attributes

    node['rackspace_holland']['server_holland_password'] - Holland password.
    node['rackspace_holland']['dir'] - Backup directory location.
    node['rackspace_holland']['rhel_ver'] - RHEL/CentOS version-release e.g. `1.0.10-1.el6`
    node['rackspace_holland']['install']['container'] - Holland image location.

    node['rackspace_holland']['install']['main'] - Main package file name e.g. `debian72-holland_1.0.10-1_all.deb`
    node['rackspace_holland']['install']['common'] = Common package file name.
    node['rackspace_holland']['install']['mysqldump'] = mysqldump package file name.

Cookbook template overrides:

    node['rackspace_holland']['templates_cookbook']['node.conf'] = 'rackspace_holland'
    node['rackspace_holland']['templates_cookbook']['holland.conf'] = 'rackspace_holland'
    node['rackspace_holland']['templates_cookbook']['holland.cron'] = 'rackspace_holland'
    node['rackspace_holland']['templates_cookbook']['holland.sql'] = 'rackspace_holland'
    
backupsets/node.conf.erb attributes

    # holland
    node['rackspace_holland']['config']['node.conf']['holland']['keep'] - Days to keep backup.
    node['rackspace_holland']['config']['node.conf']['holland']['auto_purge_failures'] - Automatically clean up on failure.
    node['rackspace_holland']['config']['node.conf']['holland']['purge_policy'] = 'after-backup'
    node['rackspace_holland']['config']['node.conf']['holland']['estimated_size_factor'] = '1.0'
    
    # mysqldump
    node['rackspace_holland']['config']['node.conf']['mysqldump']['file_per_database'] - One file per database.
    
    # compression
    node['rackspace_holland']['config']['node.conf']['compression']['method'] - Defaults to 'gzip'
    node['rackspace_holland']['config']['node.conf']['compression']['options'] - Compression options.
    
holland.conf.erb attributes

    node['rackspace_holland']['config']['holland.conf']['logging']['log_file'] - Holland log file.
    node['rackspace_holland']['config']['holland.conf']['logging']['level'] - debug, info, warning, error or critical


Usage
-----
#### rackspace_holland::default
Just include `recipe[rackspace_holland::mysqldump]` in your node's `run_list`.

License & Authors
-----------------
- Author:: BK Box (<bk.box@rackspace.com>)
- Author:: Ted Neykov (<ted.neykov@rackspace.com>)

```text
Copyright:: 2014 Rackspace, US Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
