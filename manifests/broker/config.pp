# == Class kafka::broker::config
#
# This private class is called from kafka::broker to manage the configuration
#
class kafka::broker::config(
  $install_dir = $kafka::broker::install_dir
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $server_config = merge($kafka::params::broker_config_defaults, $kafka::broker::config)

  file { "${install_dir}/config/server.properties":
    owner   => 'kafka',
    group   => 'kafka',
    mode    => '0644',
    alias   => 'kafka-cfg',
    require => [ Exec['untar-kafka'], File['/usr/local/kafka'] ],
    content => template('kafka/server.properties.erb')
  }
  
  file { "/opt/kafka":
    ensure => link,
    target => $install_dir
  }

  file { '/var/log/kafka':
    ensure => directory,
    owner  => 'kafka',
    group  => 'kafka'
  }

}
