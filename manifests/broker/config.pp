# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::broker::config
#
# This private class is meant to be called from `kafka::broker`.
# It manages the broker config files
#
class kafka::broker::config(
  $config          = $kafka::broker::config,
  $config_defaults = $kafka::broker::config_defaults,
  $install_dir     = $kafka::broker::install_dir,
  $service_restart = $kafka::broker::service_restart,
  $service_install = $kafka::broker::service_install,
  $config_dir      = $kafka::broker::config_dir,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $version = $kafka::version
  if $version and versioncmp($version, '0.9.0.0') < 0 {
    if $config['broker.id'] == '-1' {
      fail('[Broker] You need to specify a value for broker.id')
    }
  }

  $server_config = deep_merge($config_defaults, $config)

  if $service_install {
    $config_notify = $service_restart ? {
      true  => Service['kafka'],
      false => undef
    }
  } else {
    $config_notify = undef
  }

  file { "${config_dir}/server.properties":
    ensure  => present,
    owner   => 'kafka',
    group   => 'kafka',
    mode    => '0644',
    content => template('kafka/server.properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
