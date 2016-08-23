#
# Cookbook Name:: apache2_configure_as_proxy
# Recipe:: apache2_conf
#
# Copyright (c) 2016 Michael Doederlein, All Rights Reserved.

# Update ServerName in /etc/apache2/apache2.conf

# configure FQDN in odoo.conf
execute "ServerName" do
  command 'cat /tmp/foo.txt | sed "s/^/ServerName /" >> /etc/apache2/apache2.conf && rm /tmp/foo.txt'
end

# reload apache
service 'apache2' do
  action [:reload]
end
