require 'spec_helper'

describe 'rackspace_holland::mysqldump' do
  context 'Ubuntu 12.04' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

    it "sets node.default['rackspace_mysql']['install_root_my_cnf'] to true" do
      expect(chef_run.node['rackspace_mysql']['install_root_my_cnf']).to eq(true)
    end

    it 'includes the client recipe' do
      expect(chef_run).to include_recipe('rackspace_mysql::client')
    end

    it 'includes the common recipe' do
      expect(chef_run).to include_recipe('rackspace_holland::common')
    end

    it 'downloads the holland-mysqldump package if missing' do
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + '/ubuntu1204-holland-mysqldump_1.0.10-1_all.deb')
    end

    it 'installs the holland-mysqldump package' do
      expect(chef_run).to install_package('holland-mysqldump')
    end

    it 'creates /etc/holland/holland.conf template from holland.conf.erb' do
      expect(chef_run).to render_file('/etc/holland/holland.conf')
    end

    it 'creates /etc/holland/backupsets/default.conf template from backupsets/default.conf.erb' do
      expect(chef_run).to render_file('/etc/holland/backupsets/default.conf')
    end

    it 'creates /etc/holland/holland.sql template from holland.sql.erb' do
      expect(chef_run).to render_file('/etc/holland/holland.sql')
    end

    it 'executes command' do
      expect(chef_run).to run_execute('/usr/bin/mysql -u root < /etc/holland/holland.sql')
    end

    it 'creates /etc/cron.d/holland template from holland.cron.erb' do
      expect(chef_run).to render_file('/etc/cron.d/holland')
    end
  end

  context 'Debian 7' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'debian', version: '7.2').converge(described_recipe) }

    it "sets node.default['rackspace_mysql']['install_root_my_cnf'] to true" do
      expect(chef_run.node['rackspace_mysql']['install_root_my_cnf']).to eq(true)
    end

    it 'includes the client recipe' do
      expect(chef_run).to include_recipe('rackspace_mysql::client')
    end

    it 'includes the common recipe' do
      expect(chef_run).to include_recipe('rackspace_holland::common')
    end

    it 'downloads the holland-mysqldump package if missing' do
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + '/debian72-holland-mysqldump_1.0.10-1_all.deb')
    end

    it 'installs the holland-mysqldump package' do
      expect(chef_run).to install_package('holland-mysqldump')
    end

    it 'creates /etc/holland/holland.conf template from holland.conf.erb' do
      expect(chef_run).to render_file('/etc/holland/holland.conf')
    end

    it 'creates /etc/holland/backupsets/default.conf template from backupsets/default.conf.erb' do
      expect(chef_run).to render_file('/etc/holland/backupsets/default.conf')
    end

    it 'creates /etc/holland/holland.sql template from holland.sql.erb' do
      expect(chef_run).to render_file('/etc/holland/holland.sql')
    end

    it 'executes command' do
      expect(chef_run).to run_execute('/usr/bin/mysql -u root < /etc/holland/holland.sql')
    end

    it 'creates /etc/cron.d/holland template from holland.cron.erb' do
      expect(chef_run).to render_file('/etc/cron.d/holland')
    end
  end

  context 'CentOS 6' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4').converge(described_recipe) }

    it "sets node.default['rackspace_mysql']['install_root_my_cnf'] to true" do
      expect(chef_run.node['rackspace_mysql']['install_root_my_cnf']).to eq(true)
    end

    it 'includes the client recipe' do
      expect(chef_run).to include_recipe('rackspace_mysql::client')
    end

    it 'includes the common recipe' do
      expect(chef_run).to include_recipe('rackspace_holland::common')
    end

    it 'installs the holland-mysqldump package' do
      expect(chef_run).to install_package('holland-mysqldump')
    end
  end

  context 'RedHat 6' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'redhat', version: '6.3').converge(described_recipe) }

    it "sets node.default['rackspace_mysql']['install_root_my_cnf'] to true" do
      expect(chef_run.node['rackspace_mysql']['install_root_my_cnf']).to eq(true)
    end

    it 'includes the client recipe' do
      expect(chef_run).to include_recipe('rackspace_mysql::client')
    end

    it 'includes the common recipe' do
      expect(chef_run).to include_recipe('rackspace_holland::common')
    end

    it 'installs the holland-mysqldump package' do
      expect(chef_run).to install_package('holland-mysqldump')
    end
  end
end
