# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::mirror::config
#
# This private class is meant to be called from `kafka::mirror`.
# It manages the mirror-maker config files
#
class kafka::mirror::config(
  Stdlib::Absolutepath $config_dir = $kafka::mirror::config_dir,
  String $service_name             = $kafka::mirror::service_name,
  Boolean $service_install         = $kafka::mirror::service_install,
  Boolean $service_restart         = $kafka::mirror::service_restart,
  Hash $consumer_config            = $kafka::mirror::consumer_config,
  Hash $producer_config            = $kafka::mirror::producer_config,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $consumer_config['group.id'] == '' {
    fail('[Consumer] You need to specify a value for group.id')
  }
  if $consumer_config['zookeeper.connect'] == '' {
    fail('[Consumer] You need to specify a value for zookeeper.connect')
  }
  if $producer_config['bootstrap.servers'] == '' {
    fail('[Producer] You need to specify a value for bootstrap.servers')
  }

  class { '::kafka::consumer::config':
    config_dir      => $config_dir,
    service_name    => $service_name,
    service_install => $service_install,
    service_restart => $service_restart,
    config          => $consumer_config,
  }

  class { '::kafka::producer::config':
    config_dir      => $config_dir,
    service_name    => $service_name,
    service_install => $service_install,
    service_restart => $service_restart,
    config          => $producer_config,
  }
}
