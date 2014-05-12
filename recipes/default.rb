#
# Cookbook Name:: graphite
# Recipe:: default
#
# Copyright 2014, Marcy
#
# All rights reserved - Do Not Redistribute
#

include_recipe "mysql::server"

mysql_connection_info = {:host => "localhost",
                         :username => "root",
                         :password => node['mysql']['server_root_password']}

file "/etc/sysconfig/network" do
  action :create_if_missing
  owner "root"
  group "root"
  mode "0644"
end

if node['platform'] == "amazon" then
  releasever = "6"
else
  releasever = "$releasever"
end

yum_repository "epel" do
  description "epel repo"
  baseurl "https://dl.fedoraproject.org/pub/epel/#{releasever}/$basearch/"
  gpgkey  "http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-#{releasever}"
  enabled true
end

%w{graphite-web graphite-web-selinux MySQL-python python-carbon}.each do |pack|
  package pack do
    action :install
  end
end

template "/etc/graphite-web/local_settings.py" do
  source "local_settings.py.erb"
  owner "root"
  group "root"
  mode "0644"
end

mysql_database "graphite" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "graphite" do
  connection mysql_connection_info
  host "localhost"
  password node[:grahite][:mysql_password]
  database_name "graphite"
  privileges [:all]
  action [:create, :grant]
end

# service "carbon-cache" do
#   supports :status => true, :restart => true, :reload => true
#   action [ :enable, :start ]
# end

# service "httpd" do
#   supports :status => true, :restart => true, :reload => true
#   action [ :enable, :start ]
# end


  