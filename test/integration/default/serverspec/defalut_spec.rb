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

describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end

describe service('carbon-cache') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe port(3306) do
  it { should be_listening }
end

describe file('/etc/graphite-web/local_settings.py') do
  it { should be_file }
  its(:content) { should match /TIME_ZONE\s*=\s*'Asia\/Tokyo'/ }
  its(:content) { should match /'PASSWORD':\s'graphite'/ }
end

describe file('/usr/lib/python2.6/storage') do
  it { should be_directory }
end

describe file('/usr/lib/python2.6/storage/log/webapp') do
  it { should be_directory }
end

describe file('/usr/lib/python2.6/storage/whisper') do
  it { should be_linked_to '/var/lib/carbon/whisper' }
end

describe file('/etc/httpd/conf.d/graphite-web.conf') do
  it { should be_file }
  its(:content) { should match /^<VirtualHost\s\*:80>$/ }
  its(:content) { should match /^\s*ServerName\sgraphite-web$/ }
end

describe file('/etc/carbon/carbon.conf') do
  it { should be_file }
  its(:content) { should match /^STORAGE_DIR\s*=\s*\/var\/lib\/carbon\/$/ }
  its(:content) { should match /^LOCAL_DATA_DIR\s*=\s*\/var\/lib\/carbon\/whisper\/$/ }
  its(:content) { should match /^ENABLE_LOGROTATION\s*=\s*True$/ }
  its(:content) { should match /^MAX_UPDATES_PER_SECOND\s*=\s*500$/ }
  its(:content) { should match /^MAX_CREATES_PER_MINUTE\s*=\s*50$/ }
  its(:content) { should match /^LINE_RECEIVER_INTERFACE\s*=\s*0\.0\.0\.0$/ }
  its(:content) { should match /^LINE_RECEIVER_PORT\s*=\s*2003$/ }
  its(:content) { should match /^ENABLE_UDP_LISTENER\s*=\s*False$/ }
  its(:content) { should match /^UDP_RECEIVER_INTERFACE\s*=\s*0\.0\.0\.0$/ }
  its(:content) { should match /^UDP_RECEIVER_PORT\s*=\s*2003$/ }
  its(:content) { should match /^PICKLE_RECEIVER_INTERFACE\s*=\s*0\.0\.0\.0$/ }
  its(:content) { should match /^PICKLE_RECEIVER_PORT\s*=\s*2004$/ }
  its(:content) { should match /^LOG_LISTENER_CONNECTIONS\s*=\s*True$/ }
  its(:content) { should match /^USE_INSECURE_UNPICKLER\s*=\s*False$/ }
  its(:content) { should match /^CACHE_QUERY_INTERFACE\s*=\s*0\.0\.0\.0$/ }
  its(:content) { should match /^CACHE_QUERY_PORT\s*=\s*7002$/ }
  its(:content) { should match /^USE_FLOW_CONTROL\s*=\s*True$/ }
  its(:content) { should match /^LOG_UPDATES\s*=\s*False$/ }
  its(:content) { should match /^LOG_CACHE_HITS\s*=\s*False$/ }
  its(:content) { should match /^LOG_CACHE_QUEUE_SORTS\s*=\s*True$/ }
  its(:content) { should match /^CACHE_WRITE_STRATEGY\s*=\s*sorted$/ }
  its(:content) { should match /^WHISPER_AUTOFLUSH\s*=\s*False$/ }
  its(:content) { should match /^WHISPER_FALLOCATE_CREATE\s*=\s*True$/ }
end
