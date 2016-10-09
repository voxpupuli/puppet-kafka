# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::producer::service
#
# This private class is meant to be called from `kafka::producer`.
# It manages the kafka-producer service
#
class kafka::producer::service(
  $input                      = $kafka::producer::input,
  $service_config             = $kafka::producer::service_config,
  $service_defaults           = $kafka::producer::service_defaults,
  $service_requires_zookeeper = $kafka::producer::service_requires_zookeeper,
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
  }

  $service_name = 'kafka-producer'

  file { "/etc/init.d/${service_name}":
    ensure  => file,
    mode    => '0755',
    content => template('kafka/init.erb'),
    before  => Service[$service_name],
  }

  service { $service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
