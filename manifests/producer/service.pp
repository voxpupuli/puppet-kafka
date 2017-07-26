# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::producer::service
#
# This private class is meant to be called from `kafka::producer`.
# It manages the kafka-producer service
#
class kafka::producer::service(
  String $user                               = $kafka::producer::user,
  String $group                              = $kafka::producer::group,
  Stdlib::Absolutepath $config_dir           = $kafka::producer::config_dir,
  Stdlib::Absolutepath $log_dir              = $kafka::producer::log_dir,
  Stdlib::Absolutepath $bin_dir              = $kafka::producer::bin_dir,
  String $service_name                       = $kafka::producer::service_name,
  Boolean $service_install                   = $kafka::producer::service_install,
  Enum['running', 'stopped'] $service_ensure = $kafka::producer::service_ensure,
  Boolean $service_requires_zookeeper        = $kafka::producer::service_requires_zookeeper,
  Integer $limit_nofile                      = $kafka::producer::limit_nofile,
  Hash $env                                  = $kafka::producer::env,
  $input                                     = $kafka::producer::input,
  $producer_jmx_opts                         = $kafka::producer::producer_jmx_opts,
  $producer_log4j_opts                       = $kafka::producer::producer_log4j_opts,
  $service_config                            = $kafka::producer::service_config,
  $service_defaults                          = $kafka::producer::service_defaults,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $service_install {
    $producer_service_config = deep_merge($service_defaults, $service_config)

    if $producer_service_config['broker-list'] == '' {
      fail('[Producer] You need to specify a value for broker-list')
    }
    if $producer_service_config['topic'] == '' {
      fail('[Producer] You need to specify a value for topic')
    }

    $env_defaults = {
      'KAFKA_JMX_OPTS'   => $producer_jmx_opts,
      'KAFKA_LOG4J_OPTS' => $producer_log4j_opts,
    }
    $environment = deep_merge($env_defaults, $env)

    if $::service_provider == 'systemd' {
      fail('Console Producer is not supported on systemd, because the stdin of the process cannot be redirected')
    } else {
      file { "/etc/init.d/${service_name}":
        ensure  => file,
        mode    => '0755',
        content => template('kafka/init.erb'),
        before  => Service[$service_name],
      }
    }

    service { $service_name:
      ensure     => $service_ensure,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
