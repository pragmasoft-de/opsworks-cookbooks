#
# Cookbook Name:: odoo_v9_install
# Recipe:: install_apache
#
# Copyright (c) 2016 Michael Doederlein, All Rights Reserved.
#
include_recipe 'apt'
include_recipe 'apache2'
include_recipe 'apache2::mod_proxy_http'
include_recipe 'apache2::mod_headers'
include_recipe 'apache2::mod_rewrite'
include_recipe 'apache2::mod_ssl'
