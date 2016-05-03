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

template '/etc/holland/holland.conf' do
  cookbook node['rackspace_holland']['templates_cookbook']['holland.conf']
  source 'holland.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables(
    backupsets: 'default'
  )
end

template '/etc/holland/backupsets/default.conf' do
  cookbook node['rackspace_holland']['templates_cookbook']['default.conf']
  source 'backupsets/default.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables(
    plugin: 'mysqldump'
  )
end

template '/etc/cron.d/holland' do
  cookbook node['rackspace_holland']['templates_cookbook']['holland.cron']
  source 'holland.cron.erb'
  mode 0644
  owner 'root'
  group 'root'
end
