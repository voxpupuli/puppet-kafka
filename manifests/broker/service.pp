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
  $service_ensure = $kafka::broker::service_ensure
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $service_install {
    file { '/etc/init.d/kafka':
      ensure  => present,
      mode    => '0755',
      content => template('kafka/init.erb')
    }

    service { 'kafka':
      ensure     => $service_ensure,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      require    => File['/etc/init.d/kafka']
    }
  } else {
    debug('Skipping service install')
  }

}
