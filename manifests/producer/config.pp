class kafka::producer::config(
  $config = ''
) {

  $producer_config = deep_merge($config, $kafka::params::producer_config_defaults)
  
  file { '/opt/kafka/conf/producer.properties':
    ensure  => present,
    mode    => '0755',
    content => template('kafka/producer.properties.erb'),
    require => File['/opt/kafka/conf']
  }
  
}
