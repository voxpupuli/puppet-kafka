require 'spec_helper_acceptance'

describe 'zookeeper prereq' do
  zookeeper = <<-EOS
    if $::osfamily == 'RedHat' {
      class { 'java' :
        package => 'java-1.8.0-openjdk-devel',
      }

      exec { 'create pid dir':
        command => '/bin/mkdir -p /var/run/',
        creates => '/var/run/',
      }

      file { '/var/run/zookeeper/':
        ensure => directory,
        owner  => 'zookeeper',
        group  => 'zookeeper',
      }

      $zookeeper_service_provider = $facts['os']['release']['major'] ? {
        '6' => 'redhat',
        '7' => 'systemd',
      }

      class { 'zookeeper':
        install_method      => 'archive',
        archive_version     => '3.6.1',
        service_provider    => $zookeeper_service_provider,
        manage_service_file => true,
      }
    } else {
      include zookeeper
    }
  EOS

  it 'installs zookeeper with no errors' do
    apply_manifest(zookeeper, catch_failures: true)
    apply_manifest(zookeeper, catch_changes: true)
  end
end
