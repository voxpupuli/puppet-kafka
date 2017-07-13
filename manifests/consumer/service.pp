# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::consumer::service
#
# This private class is meant to be called from `kafka::consumer`.
# It manages the kafka-consumer service
#
class kafka::consumer::service(
  Hash $env                     = $kafka::consumer::env,
  $consumer_jmx_opts            = $kafka::consumer::consumer_jmx_opts,
  $consumer_log4j_opts          = $kafka::consumer::consumer_log4j_opts,
  $service_config               = $kafka::consumer::service_config,
  $service_defaults             = $kafka::consumer::service_defaults,
  $service_requires_zookeeper   = $kafka::consumer::service_requires_zookeeper,
  $limit_nofile                 = $kafka::consumer::limit_nofile,
  Stdlib::Absolutepath $bin_dir = $kafka::consumer::bin_dir,
  String $user                  = $kafka::consumer::user,
  String $group                 = $kafka::consumer::group,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $consumer_service_config = deep_merge($service_defaults, $service_config)

  if $consumer_service_config['topic'] == '' {
    fail('[Consumer] You need to specify a value for topic')
  }
  if $consumer_service_config['zookeeper'] == '' {
    fail('[Consumer] You need to specify a value for zookeeper')
  }

  $service_name = 'kafka-consumer'
  $env_defaults = {
    'KAFKA_JMX_OPTS'   => $consumer_jmx_opts,
    'KAFKA_LOG4J_OPTS' => $consumer_log4j_opts,
  }
  $environment = deep_merge($env_defaults, $env)

  if $::service_provider == 'systemd' {
    include ::systemd

    file { "${service_name}.service":
      ensure  => file,
      path    => "/etc/systemd/system/${service_name}.service",
      mode    => '0644',
      content => template('kafka/unit.erb'),
    }

    file { "/etc/init.d/${service_name}":
      ensure => absent,
    }

    File["${service_name}.service"]
    ~> Exec['systemctl-daemon-reload']
    -> Service[$service_name]

  } else {

    file { "${service_name}.service":
      ensure  => file,
      path    => "/etc/init.d/${service_name}",
      mode    => '0755',
      content => template('kafka/init.erb'),
      before  => Service[$service_name],
    }
  }

  service { $service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
