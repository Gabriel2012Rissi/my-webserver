require 'spec_helper'

describe 'Dockerfile' do
  describe 'Webserver' do
    describe package('apache2') do
      it { should be_installed }
    end
    describe service('apache2') do
      it { should be_enabled }
      it { should be_running }
    end
    describe port('80') do
      it { should be_listening }
    end
  end
  describe user('webmaster') do
    it { should exist }
    it { should belong_to_group 'www-data' }
    it { should have_home_directory 'webmaster' }
  end
  describe file('/home/webmaster/projects') do
    it { should exist }
    it { should be_directory }
    it { should be_symlink }
  end
end
