# @summary
#   This class handles the Kafka (consumer) config.
#
class kafka::consumer::config(
  Stdlib::Absolutepath $config_dir = $kafka::consumer::config_dir,
  String $service_name             = $kafka::consumer::service_name,
  Boolean $service_install         = $kafka::consumer::service_install,
  Boolean $service_restart         = $kafka::consumer::service_restart,
  Hash $config                     = $kafka::consumer::config,
  Stdlib::Filemode $config_mode    = $kafka::consumer::config_mode,
  String $user                     = $kafka::consumer::user,
  String $group                    = $kafka::consumer::group,
) {

  if ($service_install and $service_restart) {
    $config_notify = Service[$service_name]
  } else {
    $config_notify = undef
  }

  $doctag = 'consumerconfigs'
  file { "${config_dir}/consumer.properties":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => $config_mode,
    content => template('kafka/properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
