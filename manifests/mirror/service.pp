# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::mirror::service
#
# This private class is meant to be called from `kafka::mirror`.
# It manages the kafka-mirror service
#
class kafka::mirror::service(
  String $user                               = $kafka::mirror::user,
  String $group                              = $kafka::mirror::group,
  Stdlib::Absolutepath $config_dir           = $kafka::mirror::config_dir,
  Stdlib::Absolutepath $log_dir              = $kafka::mirror::log_dir,
  Stdlib::Absolutepath $bin_dir              = $kafka::mirror::bin_dir,
  String $service_name                       = $kafka::mirror::service_name,
  Boolean $service_install                   = $kafka::mirror::service_install,
  Enum['running', 'stopped'] $service_ensure = $kafka::mirror::service_ensure,
  Array[String] $service_requires            = $kafka::mirror::service_requires,
  Optional[String] $limit_nofile             = $kafka::mirror::limit_nofile,
  Optional[String] $limit_core               = $kafka::mirror::limit_core,
  Hash $env                                  = $kafka::mirror::env,
  Hash $consumer_config                      = $kafka::mirror::consumer_config,
  Hash $producer_config                      = $kafka::mirror::producer_config,
  Hash $service_config                       = $kafka::mirror::service_config,
  String $heap_opts                          = $kafka::mirror::heap_opts,
  String $jmx_opts                           = $kafka::mirror::jmx_opts,
  String $log4j_opts                         = $kafka::mirror::log4j_opts,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $service_install {
    $env_defaults = {
      'KAFKA_HEAP_OPTS'  => $heap_opts,
      'KAFKA_JMX_OPTS'   => $jmx_opts,
      'KAFKA_LOG4J_OPTS' => $log4j_opts,
    }
    $environment = deep_merge($env_defaults, $env)

    if $::service_provider == 'systemd' {
      include ::systemd

      file { "/etc/systemd/system/${service_name}.service":
        ensure  => file,
        mode    => '0644',
        content => template('kafka/unit.erb'),
      }

      file { "/etc/init.d/${service_name}":
        ensure => absent,
      }

      File["/etc/systemd/system/${service_name}.service"]
      ~> Exec['systemctl-daemon-reload']
      -> Service[$service_name]

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
