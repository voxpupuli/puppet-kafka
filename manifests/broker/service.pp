# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::broker::service
#
# This private class is meant to be called from `kafka::broker`.
# It manages the kafka service
#
class kafka::broker::service(
  $service_install              = $kafka::broker::service_install,
  $service_ensure               = $kafka::broker::service_ensure,
  $service_requires_zookeeper   = $kafka::broker::service_requires_zookeeper,
  $jmx_opts                     = $kafka::broker::jmx_opts,
  $limit_nofile                 = $kafka::broker::limit_nofile,
  $log4j_opts                   = $kafka::broker::log4j_opts,
  $heap_opts                    = $kafka::broker::heap_opts,
  $opts                         = $kafka::broker::opts,
  Hash $env                     = $kafka::broker::env,
  $config_dir                   = $kafka::broker::config_dir,
  Stdlib::Absolutepath $bin_dir = $kafka::broker::bin_dir,
  $log_dir                      = $kafka::broker::log_dir,
  String $user                  = $kafka::broker::user,
  String $group                 = $kafka::broker::group,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $service_name = 'kafka'
  $env_defaults = {
    'KAFKA_HEAP_OPTS'  => $heap_opts,
    'KAFKA_LOG4J_OPTS' => $log4j_opts,
    'KAFKA_JMX_OPTS'   => $jmx_opts,
    'KAFKA_OPTS'       => $opts,
    'LOG_DIR'          => $log_dir,
  }
  $environment = deep_merge($env_defaults, $env)

  if $service_install {
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
      ensure     => $service_ensure,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  } else {
    debug('Skipping service install')
  }
}
