#
# Cookbook Name:: odoo_v9_install
# Recipe:: odoo
#
# Copyright (c) 2016 Michael Doederlein, All Rights Reserved.

Chef::Log.info("********** running odoo_v9_install::odoo.rb **********")

# change owner of $HOME for user odoo
directory '/opt/odoo' do
  owner node['install_odoo']['user']
  group node['install_odoo']['group']
end

# sync git repository
git "#{node['install_odoo']['homedir']}/odoo-server" do
  user node['install_odoo']['user']
  group node['install_odoo']['group']
  depth 1
  repository node['install_odoo']['git_odoo_repository']
  revision node['install_odoo']['git_odoo_branch']
  action :sync
end

# make directory for custom addons
execute 'mkdir-custom-add' do
  user node['install_odoo']['user']
  group node['install_odoo']['group']
  command "mkdir -p #{node['install_odoo']['custom_addons']}"
  not_if { File.exist?("#{node['install_odoo']['custom_addons']}") }
end

# install further requirements
execute 'pip-install' do
  command 'pip install -r /opt/odoo/odoo-server/requirements.txt'
  not_if 'pip list | awk \'{print $1}\' | grep xlwt'
end
#execute 'easy_install' do
# scheinbar ist das Verzeichnis pyPdf vorhanden, auch wenn easy_install nicht gelaufen ist -> prüfen!
#  command 'easy_install pyPdf vatnumber pydot psycogreen suds ofxparse'
#  not_if { File.exist?("/usr/local/lib/python2.7/dist-packages/pyPdf") }
#end

# add log-path
directory '/var/log/odoo' do
  owner node['install_odoo']['user']
  group 'root'
end

# create odoo-server.conf from template file
template '/etc/odoo-server.conf' do
  source 'odoo-server.conf.erb'
  owner node['install_odoo']['user']
  group 'root'
  mode '0640'
end
# configure ip address in odoo-server.conf for xmlrpc_interface
#execute "ip-conf" do
#  command 'sed -i "s/local-ipv4/$(curl http://169.254.169.254/latest/meta-data/local-ipv4)/g" /etc/odoo-server.conf'
#end

# create start-/stop script
template '/etc/init.d/odoo-server' do
  source 'odoo-server.erb'
  mode '0755'
end

# enable odoo service
service 'odoo-server' do
  supports :status => true, :start => true, :stop => true, :restart => true
  action :enable
end

# start odoo service
service 'odoo-server' do
  action :start
end
