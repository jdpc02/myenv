#
# Cookbook:: setupweb
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

case node['os']
when 'linux'
  require 'mixlib/shellout'
  case node['platform_family']
  when 'rhel', 'amazon'
    tmpvar = Mixlib::ShellOut.new("systemctl status httpd")
  when 'debian'
    tmpvar = Mixlib::ShellOut.new("systemctl status apache2 | grep running")
  end
  tmpvar.run_command
  tmpvar = tmpvar.stdout
  if tmpvar.empty?
    webchk = 'x'
  else
    webchk = ''
  end
when 'windows'
  require 'chef/mixin/powershell_out'
  ::Chef::Recipe.send(:include, Chef::Mixin::PowershellOut)
  script = <<-EOH
    $results = (Get-WindowsFeature -Name Web-Server).Installed
    $results
  EOH
  tmpvar = powershell_out(script).stdout.delete("\n").delete("\r")
  if tmpvar == 'True'
    webchk = ''
  else
    webchk = tmpvar
  end
end

include_recipe 'setupweb::config' unless webchk.empty?
