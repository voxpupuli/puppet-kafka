# @summary
#   This class handles the Kafka (broker) config.
#
# @api private
#
class kafka::broker::config(
  Boolean $manage_service          = $kafka::broker::manage_service,
  String[1] $service_name          = $kafka::broker::service_name,
  Boolean $service_restart         = $kafka::broker::service_restart,
  Hash[String[1], Any] $config     = $kafka::broker::config,
  Stdlib::Absolutepath $config_dir = $kafka::broker::config_dir,
  String[1] $user_name             = $kafka::broker::user_name,
  String[1] $group_name            = $kafka::broker::group_name,
  Stdlib::Filemode $config_mode    = $kafka::broker::config_mode,
) {

  assert_private()

  if ($manage_service and $service_restart) {
    $config_notify = Service[$service_name]
  } else {
    $config_notify = undef
  }

  $doctag = 'brokerconfigs'
  file { "${config_dir}/server.properties":
    ensure  => present,
    owner   => $user_name,
    group   => $group_name,
    mode    => $config_mode,
    content => template('kafka/properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
