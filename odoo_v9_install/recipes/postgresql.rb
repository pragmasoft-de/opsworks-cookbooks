#
# Cookbook Name:: odoo_v9_install
# Recipe:: postgresql
#
# Copyright (c) 2016 Michael Doederlein, All Rights Reserved.

# Install postgresql client and server
include_recipe 'postgresql::server'
include_recipe 'postgresql::client'

# add database user
execute 'create dbuser' do
  user "postgres"
  command "createuser -s odoo"
  not_if 'psql -c \'\du\'| awk \'{print $1}\' | grep odoo'
end

# restart postgresql service
service 'postgresql' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end
