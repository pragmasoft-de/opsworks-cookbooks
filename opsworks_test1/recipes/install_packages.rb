# Cookbook Name:: install_odoo
# Recipe:: install_packages
#
# Copyright (c) 2016 Michael Doederlein, All Rights Reserved.

# install apt packages
package ['wget', 'git', 'python-pip', 'python-imaging', 'python-setuptools', 'python-dev', 'libxslt-dev', 'libxml2-dev', 'libldap2-dev', 'libsasl2-dev', 'node-less', 'postgresql-server-dev-all', 'nodejs', 'npm']

# install node packages
execute 'npm-packages' do
  command 'npm install -g less less-plugin-clean-css'
end

# download webkit
execute 'wget-download' do
  cwd '/tmp'
  command "wget #{node['install_odoo']['webkit_url']}/#{node['install_odoo']['webkit_package']}"
  not_if { File.exist?("/tmp/#{node['install_odoo']['webkit_package']}") }
end

# install further dependencies for webkit
package ['fontconfig', 'libfontconfig1', 'libx11-6', 'libxext6', 'libxrender1', 'xfonts-base', 'xfonts-75dpi']

# install webkit
execute "install-wkthmltox" do
  command "dpkg -i /tmp/#{node['install_odoo']['webkit_package']}"
#  returns [0, 1]
end

# copy webkit to target location
execute 'copy-files' do
  command 'cp /usr/local/bin/wkhtmltopdf /usr/bin && cp /usr/local/bin/wkhtmltoimage /usr/bin'
  not_if { File.exist?("/usr/bin/wkhtmltopdf") }
end

# clearance
execute 'delete-sources' do
  command "rm '/tmp/#{node['install_odoo']['webkit_package']}'"
  only_if { File.exist?("/tmp/#{node['install_odoo']['webkit_package']}") }
end
