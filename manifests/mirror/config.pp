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
  $service_restart          = $kafka::mirror::service_restart
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  ::kafka::consumer::config { 'consumer':
    config          => $consumer_config,
    config_defaults => $consumer_config_defaults,
    service_restart => $service_restart,
  }

  class { '::kafka::producer::config':
    config          => $producer_config,
    config_defaults => $producer_config_defaults,
    service_restart => $service_restart,
  }
}
