# @summary
#   This class handles the Kafka (broker) config.
#
# @api private
#
class kafka::broker::config(
  Stdlib::Absolutepath $config_dir = $kafka::broker::config_dir,
  String $service_name             = $kafka::broker::service_name,
  Boolean $service_install         = $kafka::broker::service_install,
  Boolean $service_restart         = $kafka::broker::service_restart,
  Hash $config                     = $kafka::broker::config,
  Stdlib::Filemode $config_mode    = $kafka::broker::config_mode,
  String $user                     = $kafka::broker::user,
  String $group                    = $kafka::broker::group,
) {

  assert_private()

  if ($service_install and $service_restart) {
    $config_notify = Service[$service_name]
  } else {
    $config_notify = undef
  }

  $doctag = 'brokerconfigs'
  file { "${config_dir}/server.properties":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => $config_mode,
    content => template('kafka/properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }
}
