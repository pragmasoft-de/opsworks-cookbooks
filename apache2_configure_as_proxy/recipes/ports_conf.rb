#
# Cookbook Name:: apache2_configure_as_proxy
# Recipe:: ports_conf
#
# Copyright (c) 2016 Michael Doederlein, All Rights Reserved.

# configure /etc/apache2/ports.conf vom template-file

# create ports.conf from template file
template '/etc/apache2/ports.conf' do
  source 'ports.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# configure ip address in ports.conf
execute "ip-conf" do
  command 'sed -i "s/local-ipv4/$(curl http://169.254.169.254/latest/meta-data/local-ipv4)/g" /etc/apache2/ports.conf'
end
