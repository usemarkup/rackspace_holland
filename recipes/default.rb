#
# Cookbook Name:: rackspace_holland
# Recipe:: default
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

case node['platform']
when 'redhat', 'centos'
  package 'python-setuptools'
  package 'holland' do
    version node['rackspace_holland']['rhel_ver']
  end
when 'ubuntu', 'debian'
  package 'python-support' do
    action :install
  end

  package 'python-pkg-resources' do
    action :install
  end

  remote_file "#{Chef::Config[:file_cache_path]}/#{node['rackspace_holland']['install']['main']}" do
    source "#{node['rackspace_holland']['install']['container']}/#{node['rackspace_holland']['install']['main']}"
    action :create_if_missing
  end

  package 'holland' do
    source source "#{Chef::Config[:file_cache_path]}/#{node['rackspace_holland']['install']['main']}"
    provider Chef::Provider::Package::Dpkg
  end
end
