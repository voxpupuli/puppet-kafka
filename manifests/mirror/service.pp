# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::mirror::service
#
# This private class is meant to be called from `kafka::mirror`.
# It manages the kafka-mirror service
#
class kafka::mirror::service(
  $consumer_config  = $kafka::params::consumer_config,
  $producer_config  = $kafka::params::producer_config,
  $num_streams      = $kafka::mirror::num_streams,
  $num_producers    = $kafka::mirror::num_producers,
  $whitelist        = $kafka::mirror::whitelist,
  $blacklist        = $kafka::mirror::blacklist,
  $max_heap         = $kafka::mirror::max_heap
) inherits ::kafka::params {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $::service_provider == 'systemd' {
    include ::systemd

    file { '/usr/lib/systemd/system/kafka-mirror.service':
      ensure  => present,
      mode    => '0644',
      content => template('kafka/mirror.unit.erb'),
    }

    file { '/etc/init.d/kafka-mirror':
      ensure => absent,
    }

    File['/usr/lib/systemd/system/kafka-mirror.service'] ~> Exec['systemctl-daemon-reload'] -> Service['kafka-mirror']
  } else {
    file { '/etc/init.d/kafka-mirror':
      ensure  => present,
      mode    => '0755',
      content => template('kafka/mirror.init.erb'),
      before  => Service['kafka-mirror'],
    }
  }

  service { 'kafka-mirror':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
