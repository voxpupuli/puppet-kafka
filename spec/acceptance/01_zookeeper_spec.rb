# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'zookeeper prereq' do
  zookeeper = <<-EOS
    if $facts['os']['family'] == 'RedHat' {
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

      class { 'zookeeper':
        install_method      => 'archive',
        archive_version     => '3.6.1',
        manage_service_file => true,
        archive_dl_site     => 'https://archive.apache.org/dist/zookeeper',
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
