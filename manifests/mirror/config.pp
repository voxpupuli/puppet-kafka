# @summary
#   This class handles the Kafka (mirror) config.
#
# @api private
#
class kafka::mirror::config (
  Boolean $manage_service                       = $kafka::mirror::manage_service,
  String[1] $service_name                       = $kafka::mirror::service_name,
  Boolean $service_restart                      = $kafka::mirror::service_restart,
  Hash[String[1],String[1]] $consumer_config    = $kafka::mirror::consumer_config,
  Hash[String[1],String[1]] $producer_config    = $kafka::mirror::producer_config,
  Stdlib::Absolutepath $config_dir              = $kafka::mirror::config_dir,
  String[1] $user_name                          = $kafka::mirror::user_name,
  String[1] $group_name                         = $kafka::mirror::group_name,
  Stdlib::Filemode $config_mode                 = $kafka::mirror::config_mode,
  Boolean $manage_log4j                         = $kafka::mirror::manage_log4j,
  Pattern[/[1-9][0-9]*[KMG]B/] $log_file_size   = $kafka::mirror::log_file_size,
  Integer[1, 50] $log_file_count                = $kafka::mirror::log_file_count,
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
    manage_service  => $manage_service,
    service_name    => $service_name,
    service_restart => $service_restart,
    config          => $consumer_config,
    config_dir      => $config_dir,
    user_name       => $user_name,
    group_name      => $group_name,
    config_mode     => $config_mode,
    manage_log4j    => $manage_log4j,
    log_file_size   => $log_file_size,
    log_file_count  => $log_file_count,
  }

  class { 'kafka::producer::config':
    manage_service  => $manage_service,
    service_name    => $service_name,
    service_restart => $service_restart,
    config          => $producer_config,
    config_dir      => $config_dir,
    user_name       => $user_name,
    group_name      => $group_name,
    config_mode     => $config_mode,
  }
}
