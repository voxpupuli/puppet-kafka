define kafka::consumer::config(
  $config = {}
) {

  $consumer_config = deep_merge($config, $kafka::params::consumer_config_defaults)
  
  file { "/opt/kafka/config/${name}.properties":
    ensure  => present,
    mode    => '0755',
    content => template('kafka/consumer.properties.erb'),
    require => File['/opt/kafka/config']
  }
  
}
