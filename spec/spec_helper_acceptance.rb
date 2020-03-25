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
      next unless fact('os.name') == 'Debian' && fact('os.release.major') == '8'
      on host, 'echo "deb http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list'
      on host, 'echo \'Acquire::Check-Valid-Until "false";\' > /etc/apt/apt.conf.d/check-valid'
      on host, 'DEBIAN_FRONTEND=noninteractive apt-get -y update'
      on host, 'DEBIAN_FRONTEND=noninteractive apt-get install -y -t jessie-backports openjdk-8-jdk'
    end
  end
end
