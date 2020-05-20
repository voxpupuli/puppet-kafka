# @summary
#   This class handles the Kafka (producer) config.
#
class kafka::producer::config(
  Boolean $manage_service          = $kafka::producer::manage_service,
  String[1] $service_name          = $kafka::producer::service_name,
  Boolean $service_restart         = $kafka::producer::service_restart,
  Hash[String[1], Any] $config     = $kafka::producer::config,
  Stdlib::Absolutepath $config_dir = $kafka::producer::config_dir,
  String[1] $user_name             = $kafka::producer::user_name,
  String[1] $group_name            = $kafka::producer::group_name,
  Stdlib::Filemode $config_mode    = $kafka::producer::config_mode,
) {

  if ($manage_service and $service_restart) {
    $config_notify = Service[$service_name]
  } else {
    $config_notify = undef
  }

  $doctag = 'producerconfigs'
  file { "${config_dir}/producer.properties":
    ensure  => present,
    owner   => $user_name,
    group   => $group_name,
    mode    => $config_mode,
    content => template('kafka/properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
