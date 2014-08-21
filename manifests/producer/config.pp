class kafka::producer::config(
  $config = ''
) {

  $producer_config = deep_merge($kafka::params::producer_config_defaults, $config)
  
  file { '/opt/kafka/config/producer.properties':
    ensure  => present,
    mode    => '0755',
    content => template('kafka/producer.properties.erb'),
    require => File['/opt/kafka/config']
  }
  
}
