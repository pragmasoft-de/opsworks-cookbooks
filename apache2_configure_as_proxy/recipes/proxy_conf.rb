#
# Cookbook Name:: apache2_configure_as_proxy
# Recipe:: proxy_conf
#
# Copyright (c) 2016 Michael Doederlein, All Rights Reserved.

# comment all lines in /etc/apache2/mods-available/proxy.conf to make apache work as reverse proxy

# create odoo-server.conf from template file
template '/etc/apache2/mods-available/proxy.conf' do
  source 'proxy.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# reload apache
service 'apache2' do
  action [:reload]
end

