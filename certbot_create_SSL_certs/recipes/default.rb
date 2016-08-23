#
# Cookbook Name:: certbot_create_SSL_certs
# Recipe:: default
#
# Copyright (c) 2016 Michael Doederlein, All Rights Reserved.

depends 'certbot', '>= 0.1.0'

certbot_certonly_webroot 'create_SSL_certs' do
   webroot_path '/var/www/certbot'
   email 'michael.doederlein@cloud-logic.net'
#   domains ['domain1.com', 'domain2.com']
   domains node[:hostname] + '.cloud-logic.de'
   agree_tos true
end
