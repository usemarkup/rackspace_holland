#
# Cookbook Name:: rackspace_holland
# Recipe:: common
#
# Copyright 2014, Rackspace, US Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'rackspace_holland'

case node['platform']
when 'redhat', 'centos'
  package 'MySQL-python'
  package 'holland-common'
when 'ubuntu', 'debian'
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
