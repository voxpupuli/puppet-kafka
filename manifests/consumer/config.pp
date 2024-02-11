# @summary
#   This class handles the Kafka (consumer) config.
#
class kafka::consumer::config (
  Boolean $manage_service                       = $kafka::consumer::manage_service,
  String[1] $service_name                       = $kafka::consumer::service_name,
  Boolean $service_restart                      = $kafka::consumer::service_restart,
  Hash[String[1], Any] $config                  = $kafka::consumer::config,
  Stdlib::Absolutepath $config_dir              = $kafka::consumer::config_dir,
  String[1] $user_name                          = $kafka::consumer::user_name,
  String[1] $group_name                         = $kafka::consumer::group_name,
  Stdlib::Filemode $config_mode                 = $kafka::consumer::config_mode,
  Boolean $manage_log4j                         = $kafka::consumer::manage_log4j,
  Pattern[/[1-9][0-9]*[KMG]B/] $log_file_size   = $kafka::consumer::log_file_size,
  Integer[1, 50] $log_file_count                = $kafka::consumer::log_file_count,
) {
  if ($manage_service and $service_restart) {
    $config_notify = Service[$service_name]
  } else {
    $config_notify = undef
  }

  $doctag = 'consumerconfigs'
  file { "${config_dir}/consumer.properties":
    ensure  => file,
    owner   => $user_name,
    group   => $group_name,
    mode    => $config_mode,
    content => template('kafka/properties.erb'),
    notify  => $config_notify,
    require => File[$config_dir],
  }

  if $manage_log4j {
    file { "${config_dir}/log4j.properties":
      ensure  => file,
      owner   => $user_name,
      group   => $group_name,
      mode    => $config_mode,
      content => epp('kafka/log4j.properties.epp', { 'log_file_size' => $log_file_size, 'log_file_count' => $log_file_count }),
      notify  => $config_notify,
      require => File[$config_dir],
    }
  }
}
