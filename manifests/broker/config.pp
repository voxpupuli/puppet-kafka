# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::broker::config
#
# This private class is meant to be called from `kafka::broker`.
# It manages the broker config files
#
class kafka::broker::config(
  Stdlib::Absolutepath $config_dir = $kafka::broker::config_dir,
  String $service_name             = $kafka::broker::service_name,
  Boolean $service_install         = $kafka::broker::service_install,
  Boolean $service_restart         = $kafka::broker::service_restart,
  Hash $config                     = $kafka::broker::config,
) {

  if ($caller_module_name != $module_name) {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if ($service_install and $service_restart) {
    $config_notify = Service[$service_name]
  } else {
    $config_notify = undef
  }

  $doctag = 'brokerconfigs'
  file { "${config_dir}/server.properties":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('kafka/properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
