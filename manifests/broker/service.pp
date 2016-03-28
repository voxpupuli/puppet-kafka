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
  $gc_opts         = $kafka::broker::gc_opts,
  $log4j_opts      = $kafka::broker::log4j_opts,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $service_install {
    file { '/etc/init.d/kafka':
      ensure  => present,
      mode    => '0755',
      content => template('kafka/init.erb'),
    }

    if $::osfamily == 'RedHat' and $::operatingsystemmajrelease == '7' {
      exec { 'systemctl daemon-reload # for kafka':
        command     => '/bin/systemctl daemon-reload',
        refreshonly => true,
        subscribe   => File['/etc/init.d/kafka'],
        before      => Service['kafka'],
      }
    }

    service { 'kafka':
      ensure     => $service_ensure,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      require    => File['/etc/init.d/kafka'],
    }
  } else {
    debug('Skipping service install')
  }
}
