# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::mirror::service
#
# This private class is meant to be called from `kafka::mirror`.
# It manages the kafka-mirror service
#
class kafka::mirror::service(
  $consumer_configs = $kafka::mirror::consumer_configs,
  $producer_config  = $kafka::mirror::producer_config,
  $num_streams      = $kafka::mirror::num_streams,
  $num_producers    = $kafka::mirror::num_producers,
  $whitelist        = $kafka::mirror::whitelist,
  $blacklist        = $kafka::mirror::blacklist,
  $max_heap         = $kafka::mirror::max_heap
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { '/etc/init.d/kafka-mirror':
    ensure  => present,
    mode    => '0755',
    content => template('kafka/mirror.init.erb'),
  }

  service { 'kafka-mirror':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/etc/init.d/kafka-mirror'],
  }
}
