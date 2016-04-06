# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::producer::service
#
# This private class is meant to be called from `kafka::producer`.
# It manages the kafka-producer service
#
class kafka::producer::service(
  $input            = $kafka::producer::input,
  $service_config   = $kafka::producer::service_config,
  $service_defaults = $kafka::producer::service_defaults,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $producer_service_config = deep_merge($service_defaults, $service_config)

  if $producer_service_config['broker-list'] == '' {
    fail('[Producer] You need to specify a value for broker-list')
  }
  if $producer_service_config['topic'] == '' {
    fail('[Producer] You need to specify a value for topic')
  }

  if $::service_provider == 'systemd' {
    fail('Console Producer is not supported on systemd, because the stdin of the process cannot be redirected')
  } else {
    file { '/etc/init.d/kafka-producer':
      ensure  => present,
      mode    => '0755',
      content => template('kafka/producer.init.erb'),
      before  => Service['kafka-producer'],
    }
  }

  service { 'kafka-producer':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
