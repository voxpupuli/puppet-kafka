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
  Boolean $manage_service          = $kafka::broker::manage_service,
  Boolean $service_restart         = $kafka::broker::service_restart,
  Hash $config                     = $kafka::broker::config,
  Stdlib::Filemode $config_mode    = $kafka::broker::config_mode,
  String $user_name                = $kafka::broker::user_name,
  String $group_name               = $kafka::broker::group_name,
) {

  assert_private()

  if ($manage_service and $service_restart) {
    $config_notify = Service[$service_name]
  } else {
    $config_notify = undef
  }

  $doctag = 'brokerconfigs'
  file { "${config_dir}/server.properties":
    ensure  => present,
    owner   => $user_name,
    group   => $group_name,
    mode    => $config_mode,
    content => template('kafka/properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
