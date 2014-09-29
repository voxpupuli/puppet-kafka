# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::mirror::config
#
# This private class is meant to be called from `kafka::mirror`.
# It manages the mirror-maker config files
#
class kafka::mirror::config(
  $consumer_config = $kafka::mirror::consumer_config,
  $producer_config = $kafka::mirror::producer_config
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  class { 'kafka::producer::config':
    config => $producer_config
  }

  create_resources('kafka::consumer::config', $consumer_config)
}
