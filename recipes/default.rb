#
# Cookbook Name:: rackspace_holland
# Recipe:: default
#
# Copyright 2014, Rackspace, US Inc.
#
# All rights reserved - Do Not Redistribute
#

case node['platform']
when 'redhat', 'centos'
  package 'python-setuptools'
  package 'holland'
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
