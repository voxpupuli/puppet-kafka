# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::consumer::config
#
# This private class is meant to be called from `kafka::consumer`.
# It manages the consumer config files
#
define kafka::consumer::config(
  $config          = $kafka::consumer::config,
  $config_defaults = $kafka::consumer::config_defaults,
  $service_name    = 'kafka-consumer',
  $service_restart = $kafka::consumer::service_restart,
  $config_dir      = $kafka::consumer::config_dir,
) {

  $consumer_config = deep_merge($config_defaults, $config)

  $config_notify = $service_restart ? {
    true    => Service[$service_name],
    default => undef
  }

  file { "${config_dir}/${name}.properties":
    ensure  => present,
    owner   => 'kafka',
    group   => 'kafka',
    mode    => '0644',
    content => template('kafka/consumer.properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
