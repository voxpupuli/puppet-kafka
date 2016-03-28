# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::consumer::service
#
# This private class is meant to be called from `kafka::consumer`.
# It manages the kafka-consumer service
#
class kafka::consumer::service(
  $service_config   = $kafka::consumer::service_config,
  $service_defaults = $kafka::consumer::service_defaults
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

  file { '/etc/init.d/kafka-consumer':
    ensure  => present,
    mode    => '0755',
    content => template('kafka/consumer.init.erb'),
  }

  if $::osfamily == 'RedHat' and $::operatingsystemmajrelease == '7' {
    exec { 'systemctl daemon-reload # for kafka-consumer':
      command     => '/bin/systemctl daemon-reload',
      refreshonly => true,
      subscribe   => File['/etc/init.d/kafka-consumer'],
      before      => Service['kafka-consumer'],
    }
  }

  service { 'kafka-consumer':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/etc/init.d/kafka-consumer'],
  }
}
