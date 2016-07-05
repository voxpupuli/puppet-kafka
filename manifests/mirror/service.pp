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

  $service_name = 'kafka-mirror'

  if $::service_provider == 'systemd' {
    include ::systemd

    file { "${service_name}.service":
      ensure  => file,
      path    => "/etc/systemd/system/${service_name}.service",
      mode    => '0644',
      content => template('kafka/unit.erb'),
    }

    file { "/etc/init.d/${service_name}":
      ensure => absent,
    }

    File["${service_name}.service"] ~>
    Exec['systemctl-daemon-reload'] ->
    Service[$service_name]

  } else {

    file { "${service_name}.service":
      ensure  => file,
      path    => "/etc/init.d/${service_name}",
      mode    => '0755',
      content => template('kafka/init.erb'),
      before  => Service[$service_name],
    }
  }

  service { $service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
