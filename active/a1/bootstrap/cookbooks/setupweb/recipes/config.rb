#
# Cookbook:: setupweb
# Recipe:: config
#
# Copyright:: 2019, The Authors, All Rights Reserved.

case node['os']
when 'linux'
  case node['platform_family']
  when 'rhel'
    package 'httpd'
    
    bash 'enable firewall rules for httpd' do
        code <<-EOH
          firewall-cmd --permanent --add-port=80/tcp
          firewall-cmd --permanent --add-port=443/tcp
          firewall-cmd --reload
        EOH
        only_if 'firewall-cmd --state'
      end

    service 'httpd' do
      supports :status => true, :restart => true, :reload => true
      action [ :enable, :start ]
    end
  when 'debian'
    package 'apache2'
    bash 'enable firewall rules for apache2' do
      code <<-EOH
        ufw allow 'Apache Full'
      EOH
    end
  end

  template '/var/www/html/index.html' do
    source 'index.html.erb'
    owner 'root'
    group 'root'
    mode '0774'
    variables(
      STRPARAM: node['fqdn']
    )
    action :create
  end
when 'windows'
  %w(Web-Server Web-Mgmt-Console).each do |webfeat|
    windows_feature_powershell webfeat do
      action :install
    end
  end

  template 'c:/inetpub/wwwroot/index.html' do
    source 'index.html.erb'
    variables(
      STRPARAM: node['fqdn']
    )
    action :create
  end
end
