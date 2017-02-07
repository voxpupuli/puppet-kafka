# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::mirror::config
#
# This private class is meant to be called from `kafka::mirror`.
# It manages the mirror-maker config files
#
class kafka::mirror::config(
  $consumer_config          = $kafka::mirror::consumer_config,
  $consumer_config_defaults = $kafka::mirror::consumer_config_defaults,
  $producer_config          = $kafka::mirror::producer_config,
  $producer_config_defaults = $kafka::mirror::producer_config_defaults,
  $service_restart          = $kafka::mirror::service_restart,
  $config_dir               = $kafka::mirror::config_dir,
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

  if versioncmp($kafka::version, '0.9.0.0') < 0 {
    if $producer_config['metadata.broker.list'] == '' {
      fail('[Producer] You need to specify a value for metadata.broker.list')
    }
  } else {
    if $producer_config['bootstrap.servers'] == '' {
      fail('[Producer] You need to specify a value for bootstrap.servers')
    }
  }

  ::kafka::consumer::config { 'consumer-1':
    config          => $consumer_config,
    config_defaults => $consumer_config_defaults,
    service_name    => 'kafka-mirror',
    service_restart => $service_restart,
    config_dir      => $config_dir,
  }

  class { '::kafka::producer::config':
    config          => $producer_config,
    config_defaults => $producer_config_defaults,
    service_name    => 'kafka-mirror',
    service_restart => $service_restart,
    config_dir      => $config_dir,
  }
}
