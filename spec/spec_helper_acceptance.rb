require 'beaker-rspec'
require 'beaker-puppet'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'
install_ca_certs unless ENV['PUPPET_INSTALL_TYPE'] =~ %r{pe}i
install_module_on(hosts)
install_module_dependencies_on(hosts)

RSpec.configure do |c|
  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      if host[:platform] =~ %r{el-7-x86_64} && host[:hypervisor] =~ %r{docker}
        on(host, "sed -i '/nodocs/d' /etc/yum.conf")
      end

      write_hiera_config_on(host, ['%<::osfamily>s'])
      copy_hiera_data_to(host, './spec/acceptance/hieradata/')
    end
  end
end
