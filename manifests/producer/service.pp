# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::producer::service
#
# This private class is meant to be called from `kafka::producer`.
# It manages the kafka-producer service
#
class kafka::producer::service(
  $service_config   = $kafka::producer::service_config,
  $service_defaults = $kafka::producer::service_defaults
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $producer_service_config = deep_merge($service_defaults, $service_config)

  file { '/etc/init.d/kafka-producer':
    ensure  => present,
    mode    => '0755',
    content => template('kafka/producer.init.erb'),
  }

  service { 'kafka-producer':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/etc/init.d/kafka-producer'],
  }
}
