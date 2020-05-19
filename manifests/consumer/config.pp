# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::consumer::config
#
# This private class is meant to be called from `kafka::consumer`.
# It manages the consumer config files
#
class kafka::consumer::config(
  Boolean $manage_service          = $kafka::consumer::manage_service,
  String $service_name             = $kafka::consumer::service_name,
  Boolean $service_restart         = $kafka::consumer::service_restart,
  Hash $config                     = $kafka::consumer::config,
  Stdlib::Absolutepath $config_dir = $kafka::consumer::config_dir,
  String $user_name                = $kafka::consumer::user_name,
  String $group_name               = $kafka::consumer::group_name,
  Stdlib::Filemode $config_mode    = $kafka::consumer::config_mode,
) {

  if ($manage_service and $service_restart) {
    $config_notify = Service[$service_name]
  } else {
    $config_notify = undef
  }

  $doctag = 'consumerconfigs'
  file { "${config_dir}/consumer.properties":
    ensure  => present,
    owner   => $user_name,
    group   => $group_name,
    mode    => $config_mode,
    content => template('kafka/properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
