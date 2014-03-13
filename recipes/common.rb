#
# Cookbook Name:: rackspace_holland
# Recipe:: common
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

include_recipe 'rackspace_holland'

case node['platform_family']
when 'rhel'
  package 'MySQL-python'
  package 'holland-common'
when 'debian'
  # package 'python-mysqldb'
  package 'python-mysqldb' do
    action :install
  end

  remote_file "#{Chef::Config[:file_cache_path]}/#{node['rackspace_holland']['install']['common']}" do
    source "#{node['rackspace_holland']['install']['container']}/#{node['rackspace_holland']['install']['common']}"
    action :create_if_missing
  end

  package 'holland-common' do
    source source "#{Chef::Config[:file_cache_path]}/#{node['rackspace_holland']['install']['common']}"
    provider Chef::Provider::Package::Dpkg
  end
end
