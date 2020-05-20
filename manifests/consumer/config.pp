# @summary
#   This class handles the Kafka (consumer) config.
#
class kafka::consumer::config(
  Boolean $manage_service          = $kafka::consumer::manage_service,
  String[1] $service_name          = $kafka::consumer::service_name,
  Boolean $service_restart         = $kafka::consumer::service_restart,
  Hash[String[1], Any] $config     = $kafka::consumer::config,
  Stdlib::Absolutepath $config_dir = $kafka::consumer::config_dir,
  String[1] $user_name             = $kafka::consumer::user_name,
  String[1] $group_name            = $kafka::consumer::group_name,
  Stdlib::Filemode $config_mode    = $kafka::consumer::config_mode,
) {

  if ($manage_service and $service_restart) {
    $config_notify = Service[$service_name]
  } else {
    $config_notify = undef
  }

  $doctag = 'consumerconfigs'
  file { "${config_dir}/consumer.properties":
    ensure  => present,
    owner   => $user_name,
    group   => $group_name,
    mode    => $config_mode,
    content => template('kafka/properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
