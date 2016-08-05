#
# Cookbook Name:: letsencrypt
# Recipe:: generate_ssl_certs
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# Include the recipe to install the gems
include_recipe 'letsencrypt'

# Set up contact information. Note the mailto: notation
node.set['letsencrypt']['contact'] = [ 'mailto:me@example.com' ] 
# Real certificates please...
node.set['letsencrypt']['endpoint'] = 'https://acme-v01.api.letsencrypt.org' 

site="cloud-logic.de"
sans=Array[ "www.#{site}" ]

# Set up your server here...

# Let's letsencrypt

# Generate a self-signed if we don't have a cert to prevent bootstrap problems
letsencrypt_selfsigned "#{site}" do
    crt     "/etc/apache2/ssl/#{site}.crt"
    key     "/etc/apache2/ssl/#{site}.key"
    chain    "/etc/apache2/ssl/#{site}.pem"
    owner   "www-data"
    group   "www-data"
    notifies :restart, "service[apache2]", :immediate
    not_if do
        # Only generate a self-signed cert if needed
        ::File.exists?("/etc/apache2/ssl/#{site}.crt")
    end
end

# Get and auto-renew the certificate from letsencrypt
letsencrypt_certificate "#{site}" do
    crt      "/etc/apache/ssl/#{site}.crt"
    key      "/etc/apache/ssl/#{site}.key"
    chain    "/etc/apache/ssl/#{site}.pem"
    method   "http"
    wwwroot  "/var/www/#{site}/htdocs/"
    notifies :restart, "service[apache2]"
    alt_names sans
end
