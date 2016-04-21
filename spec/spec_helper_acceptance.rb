require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

hosts.each do |_host|
  version = ENV['PUPPET_GEM_VERSION']
  install_puppet(version: version)
end

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      c.host = host

      path = File.expand_path(File.dirname(__FILE__) + '/../').split('/')
      name = path[path.length - 1].split('-')[1]

      copy_module_to(host, source: proj_root, module_name: name)

      on host, puppet('module', 'install', 'puppet-archive'), acceptable_exit_codes: [0, 1]
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), acceptable_exit_codes: [0, 1]
      on host, puppet('module', 'install', 'puppetlabs-java'), acceptable_exit_codes: [0, 1]
      on host, puppet('module', 'install', 'deric-zookeeper'), acceptable_exit_codes: [0, 1]
      on host, puppet('module', 'install', 'camptocamp-systemd', '--version 0.2.2'), acceptable_exit_codes: [0, 1]

      write_hiera_config_on(host, ['%{::osfamily}'])

      copy_hiera_data_to(host, './spec/acceptance/hieradata/')
    end
  end
end
