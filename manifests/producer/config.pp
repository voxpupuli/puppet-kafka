# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::producer::config
#
# This private class is meant to be called from `kafka::producer`.
# It manages the producer config files
#
class kafka::producer::config(
  Stdlib::Absolutepath $config_dir = $kafka::producer::config_dir,
  String $service_name             = $kafka::producer::service_name,
  Boolean $service_install         = $kafka::producer::service_install,
  Boolean $service_restart         = $kafka::producer::service_restart,
  Hash $config                     = $kafka::producer::config,
) {

  if ($service_install and $service_restart) {
    $config_notify = Service[$service_name]
  } else {
    $config_notify = undef
  }

  $doctag = 'producerconfigs'
  file { "${config_dir}/producer.properties":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('kafka/properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
