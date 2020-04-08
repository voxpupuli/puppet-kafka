# @summary
#   This class handles the Kafka (mirror) config.
#
# @api private
#
class kafka::mirror::config(
  Stdlib::Absolutepath $config_dir = $kafka::mirror::config_dir,
  String $service_name             = $kafka::mirror::service_name,
  Boolean $service_install         = $kafka::mirror::service_install,
  Boolean $service_restart         = $kafka::mirror::service_restart,
  Hash $consumer_config            = $kafka::mirror::consumer_config,
  Hash $producer_config            = $kafka::mirror::producer_config,
  Stdlib::Filemode $config_mode    = $kafka::mirror::config_mode,
  String $user                     = $kafka::mirror::user,
  String $group                    = $kafka::mirror::group,
) {

  assert_private()

  if $consumer_config['group.id'] == '' {
    fail('[Consumer] You need to specify a value for group.id')
  }
  if $consumer_config['zookeeper.connect'] == '' {
    fail('[Consumer] You need to specify a value for zookeeper.connect')
  }
  if $producer_config['bootstrap.servers'] == '' {
    fail('[Producer] You need to specify a value for bootstrap.servers')
  }

  class { 'kafka::consumer::config':
    config_dir      => $config_dir,
    config_mode     => $config_mode,
    service_name    => $service_name,
    service_install => $service_install,
    service_restart => $service_restart,
    config          => $consumer_config,
    user            => $user,
    group           => $group,
  }

  class { 'kafka::producer::config':
    config_dir      => $config_dir,
    config_mode     => $config_mode,
    service_name    => $service_name,
    service_install => $service_install,
    service_restart => $service_restart,
    config          => $producer_config,
    user            => $user,
    group           => $group,
  }
}
