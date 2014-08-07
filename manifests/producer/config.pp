class kafka::producer::config(
  $config = ''
) {

  $producer_config = deep_merge($config, $kafka::params::producer_config_defaults)
  
  file { '/opt/kafka/conf/producer.conf':
    ensure  => present,
    mode    => '0755',
    content => template('kafka/producer.config.erb'),
    require => File['/opt/kafka/conf']
  }
  
}
