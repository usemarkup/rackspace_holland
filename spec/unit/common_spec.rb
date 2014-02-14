require 'spec_helper'

describe 'rackspace_holland::common' do
  context 'Ubuntu 12.04' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

    it 'includes the rackspace_holland recipe' do
      expect(chef_run).to include_recipe('rackspace_holland')
    end

    it 'installs the python-mysqldb package' do
      expect(chef_run).to install_package('python-mysqldb')
    end

    it 'downloads the holland-common package if missing' do
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + '/ubuntu1204-holland-common_1.0.10-1_all.deb')
    end

    it 'installs the holland-common package' do
      expect(chef_run).to install_package('holland-common')
    end
  end

  context 'Debian 7' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'debian', version: '7.2').converge(described_recipe) }

    it 'includes the rackspace_holland recipe' do
      expect(chef_run).to include_recipe('rackspace_holland')
    end

    it 'installs the python-mysqldb package' do
      expect(chef_run).to install_package('python-mysqldb')
    end

    it 'downloads the holland-common package if missing' do
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + '/debian72-holland-common_1.0.10-1_all.deb')
    end

    it 'installs the holland-common package' do
      expect(chef_run).to install_package('holland-common')
    end
  end

  context 'CentOS 6' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4').converge(described_recipe) }

    it 'includes the rackspace_holland recipe' do
      expect(chef_run).to include_recipe('rackspace_holland')
    end

    it 'installs the MySQL-python package' do
      expect(chef_run).to install_package('MySQL-python')
    end

    it 'installs the holland-common package' do
      expect(chef_run).to install_package('holland-common')
    end
  end

  context 'RedHat 6' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'redhat', version: '6.3').converge(described_recipe) }

    it 'includes the rackspace_holland recipe' do
      expect(chef_run).to include_recipe('rackspace_holland')
    end

    it 'installs the MySQL-python package' do
      expect(chef_run).to install_package('MySQL-python')
    end

    it 'installs the holland-common package' do
      expect(chef_run).to install_package('holland-common')
    end
  end
end
