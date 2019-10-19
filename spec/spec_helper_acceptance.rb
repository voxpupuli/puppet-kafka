require 'beaker-rspec'
require 'beaker-puppet'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'

RSpec.configure do |c|
  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    install_module
    install_module_dependencies

    hosts.each do |host|
      next unless fact('os.name') == 'Debian' && fact('os.release.major') == '8'
      on host, 'echo "deb http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list'
      on host, 'echo \'Acquire::Check-Valid-Until "false";\' > /etc/apt/apt.conf.d/check-valid'
      on host, 'DEBIAN_FRONTEND=noninteractive apt-get -y update'
      on host, 'DEBIAN_FRONTEND=noninteractive apt-get install -y -t jessie-backports openjdk-8-jdk'
    end
  end
end
