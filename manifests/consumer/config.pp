# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::consumer::config
#
# This private class is meant to be called from `kafka::consumer`.
# It manages the consumer config files
#
define kafka::consumer::config(
  $config = {}
) {

  $consumer_config = deep_merge($kafka::params::consumer_config_defaults, $config)

  file { "/opt/kafka/config/${name}.properties":
    ensure  => present,
    mode    => '0755',
    content => template('kafka/consumer.properties.erb'),
    require => File['/opt/kafka/config']
  }

}
