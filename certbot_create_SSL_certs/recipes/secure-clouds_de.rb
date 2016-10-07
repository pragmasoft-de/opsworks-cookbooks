#
# Cookbook Name:: certbot_create_SSL_certs
# Recipe:: default
#
# Copyright (c) 2016 Michael Doederlein, All Rights Reserved.

certbot_certonly_webroot 'create_SSL_certs' do
#   webroot_path '/var/www/certbot'
   webroot_path '/var/www/html'
   email 'michael.doederlein@cloud-logic.net'
#   domains ['domain1.com', 'domain2.com']
   domains [ node[:hostname] + '.secure-clouds.de' ]
   agree_tos true
end
