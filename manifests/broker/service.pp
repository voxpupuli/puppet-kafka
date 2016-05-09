# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::broker::service
#
# This private class is meant to be called from `kafka::broker`.
# It manages the kafka service
#
class kafka::broker::service {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file {
      'kafka-upstart':
        path    => '/etc/init/kafka.conf',
        mode    => '0644',
        content => template('kafka/upstart.erb');
      'kafka-init-helper':
        ensure => 'link',
        path   => '/etc/init.d/kafka',
        target => $common::upstart_helper;
  }

  service { 'kafka':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File['kafka-upstart']
  }

}
