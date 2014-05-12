require 'serverspec'
require 'pathname'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
    c.path = '/sbin:/usr/bin'
  end
end

%w{graphite-web graphite-web-selinux MySQL-python python-carbon}.each do |pack|
  describe package(pack) do
    it { should be_installed }
  end
end

describe port(3306) do
  it { should be_listening }
end

describe file('/etc/graphite-web/local_settings.py') do
  it { should be_file }
  its(:content) { should match /'PASSWORD':\s'graphite'/ }
end
