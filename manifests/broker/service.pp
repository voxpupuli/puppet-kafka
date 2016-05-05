# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::broker::service
#
# This private class is meant to be called from `kafka::broker`.
# It manages the kafka service
#
class kafka::broker::service(
  $service_install = $kafka::broker::service_install,
  $service_ensure  = $kafka::broker::service_ensure,
  $jmx_opts        = $kafka::broker::jmx_opts,
  $log4j_opts      = $kafka::broker::log4j_opts,
  $opts            = $kafka::broker::opts
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $service_install {
    if $::service_provider == 'systemd' {
      include ::systemd

      file { '/usr/lib/systemd/system/kafka.service':
        ensure  => present,
        mode    => '0644',
        content => template('kafka/broker.unit.erb'),
      }

      file { '/etc/init.d/kafka':
        ensure => absent,
      }

      File['/usr/lib/systemd/system/kafka.service'] ~> Exec['systemctl-daemon-reload'] -> Service['kafka']
    } else {
      file { '/etc/init.d/kafka':
        ensure  => present,
        mode    => '0755',
        content => template('kafka/init.erb'),
        before  => Service['kafka'],
      }
    }

    service { 'kafka':
      ensure     => $service_ensure,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  } else {
    debug('Skipping service install')
  }
}
