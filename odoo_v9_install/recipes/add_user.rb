# Cookbook Name:: install_odoo
# Recipe:: add_user
#
# Copyright (c) 2016 Michael Doederlein, All Rights Reserved.

# add group
group 'add odoo group' do
  action :create
  group_name node['install_odoo']['group']
end

# add user
user node['install_odoo']['user'] do
  comment 'odoo system user'
  system true
  shell '/bin/false'
  home node['install_odoo']['homedir']
  manage_home true
  group node['install_odoo']['group']
end

# add odoo user to sudo group
group 'add odoo to sudo' do
  action :modify
  group_name 'sudo'
  members node['install_odoo']['user']
  append true
end
