#
# Cookbook Name:: apache2_configure_as_proxy
# Recipe:: a2ensite_odoo
#
# Copyright (c) 2016 Michael Doderlein, All Rights Reserved.

# create /etc/apache2/sites-available/odoo.conf
# enable site

Chef::Log.info("********** running apache2_configure_as_proxy::a2ensite_odoo.rb **********")

# create /etc/apache2/sites-available/odoo.conf from template file
template '/etc/apache2/sites-available/odoo.conf' do
  source 'odoo.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# configure FQDN in odoo.conf
execute "ip-conf" do
  command 'cat /etc/hostname >> /tmp/foo.txt && sed -i "s/$/.cloud-logic.de/" /tmp/foo.txt'
  command 'sed -i "s/FQDN/$(cat /tmp/foo.txt)/g" /etc/apache2/sites-available/odoo.conf'
end

# configure public ip address in odoo.conf
execute "public-ipv4-conf" do
  command 'sed -i "s/public-ipv4/$(curl http://169.254.169.254/latest/meta-data/public-ipv4)/g" /etc/apache2/sites-available/odoo.conf'
end
