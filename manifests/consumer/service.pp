# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::consumer::service
#
# This private class is meant to be called from `kafka::consumer`.
# It manages the kafka-consumer service
#
class kafka::consumer::service(
  $service_config             = $kafka::consumer::service_config,
  $service_defaults           = $kafka::consumer::service_defaults,
  $service_requires_zookeeper = $kafka::consumer::service_requires_zookeeper,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $consumer_service_config = deep_merge($service_defaults, $service_config)

  if $consumer_service_config['topic'] == '' {
    fail('[Consumer] You need to specify a value for topic')
  }
  if $consumer_service_config['zookeeper'] == '' {
    fail('[Consumer] You need to specify a value for zookeeper')
  }

  $service_name = 'kafka-consumer'

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
