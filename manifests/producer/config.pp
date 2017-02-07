# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::producer::config
#
# This private class is meant to be called from `kafka::producer`.
# It manages the producer config files
#
class kafka::producer::config(
  $config          = $kafka::producer::config,
  $config_defaults = $kafka::producer::config_defaults,
  $service_name    = 'kafka-producer',
  $service_restart = $kafka::producer::service_restart,
  $config_dir      = $kafka::producer::config_dir,
) {

  $producer_config = deep_merge($config_defaults, $config)

  $config_notify = $service_restart ? {
    true    => Service[$service_name],
    default => undef
  }

  file { "${config_dir}/producer.properties":
    ensure  => present,
    owner   => 'kafka',
    group   => 'kafka',
    mode    => '0644',
    content => template('kafka/producer.properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
