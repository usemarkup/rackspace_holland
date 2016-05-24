#
# Cookbook Name:: rackspace_holland
# Recipe:: mysqldump
#
# Copyright 2014, Rackspace, US Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require 'pathname'

node.default['rackspace_mysql']['install_root_my_cnf'] = true

include_recipe 'rackspace_mysql::client'
include_recipe 'rackspace_holland::common'

case node['platform']
when 'redhat', 'centos'
  package 'holland-mysqldump'
when 'ubuntu', 'debian'
  remote_file "#{Chef::Config[:file_cache_path]}/#{node['rackspace_holland']['install']['mysqldump']}" do
    source "#{node['rackspace_holland']['install']['container']}/#{node['rackspace_holland']['install']['mysqldump']}"
    action :create_if_missing
  end

  package 'holland-mysqldump' do
    source source "#{Chef::Config[:file_cache_path]}/#{node['rackspace_holland']['install']['mysqldump']}"
    provider Chef::Provider::Package::Dpkg
  end
end

# tell holland to backup every configured 'backupset'
template '/etc/holland/holland.conf' do
  cookbook node['rackspace_holland']['templates_cookbook']['holland.conf']
  source 'holland.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables({
    backupsets: node['rackspace_holland']['backupsets'].keys.join(',')
  })
end

# make a backupset for each 'backupset'
node['rackspace_holland']['backupsets'].each do |key, confighash|
  template "/etc/holland/backupsets/#{key}.conf" do
    cookbook node['rackspace_holland']['templates_cookbook']['default.conf']
    source 'backupsets/default.conf.erb'
    mode 0644
    owner 'root'
    group 'root'
    variables({
      :config => confighash
    })
  end
end

# ensure each backupset folder has the correct permissions
node['rackspace_holland']['backupsets'].each do |key, confighash|
  path = Pathname("#{node[:rackspace_holland][:dir]}/#{key}")
  directory path.to_s do
    recursive true
    mode "0600"
    action :create
  end
end
