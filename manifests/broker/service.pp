# @summary
#   This class handles the Kafka (broker) service.
#
# @api private
#
class kafka::broker::service (
  Boolean $manage_service                    = $kafka::broker::manage_service,
  Enum['running', 'stopped'] $service_ensure = $kafka::broker::service_ensure,
  String[1] $service_name                    = $kafka::broker::service_name,
  Boolean $service_restart                   = $kafka::broker::service_restart,
  String[1] $user_name                       = $kafka::broker::user_name,
  String[1] $group_name                      = $kafka::broker::group_name,
  Stdlib::Absolutepath $config_dir           = $kafka::broker::config_dir,
  Stdlib::Absolutepath $log_dir              = $kafka::broker::log_dir,
  Stdlib::Absolutepath $bin_dir              = $kafka::broker::bin_dir,
  Array[String[1]] $service_requires         = $kafka::broker::service_requires,
  Optional[String[1]] $limit_nofile          = $kafka::broker::limit_nofile,
  Optional[String[1]] $limit_core            = $kafka::broker::limit_core,
  Optional[String[1]] $timeout_stop          = $kafka::broker::timeout_stop,
  Boolean $exec_stop                         = $kafka::broker::exec_stop,
  Boolean $daemon_start                      = $kafka::broker::daemon_start,
  Hash $env                                  = $kafka::broker::env,
  String[1] $heap_opts                       = $kafka::broker::heap_opts,
  String[1] $jmx_opts                        = $kafka::broker::jmx_opts,
  String[1] $log4j_opts                      = $kafka::broker::log4j_opts,
  String[0] $opts                            = $kafka::broker::opts,
) {
  assert_private()

  if $manage_service {
    $env_defaults = {
      'KAFKA_HEAP_OPTS'  => $heap_opts,
      'KAFKA_JMX_OPTS'   => $jmx_opts,
      'KAFKA_LOG4J_OPTS' => $log4j_opts,
      'KAFKA_OPTS'       => $opts,
      'LOG_DIR'          => $log_dir,
    }
    $environment = deep_merge($env_defaults, $env).map |$k, $v| { "${k}=${v}" }

    include systemd

    $exec_start_content = $daemon_start ? {
      true    => "${bin_dir}/kafka-server-start.sh -daemon ${config_dir}/server.properties ",
      default => "${bin_dir}/kafka-server-start.sh ${config_dir}/server.properties",
    }
    $exec_stop_content = $exec_stop ? {
      undef   => undef,
      default => "${bin_dir}/kafka-server-stop.sh",
    }
    $type_content = $daemon_start ? {
      true    => 'forking',
      default => 'simple',
    }
    $dependency_content = $service_requires.empty ? {
      true    => undef,
      default => $service_requires,
    }
    $active_content = $service_ensure == 'running'

    systemd::manage_unit { "${service_name}.service":
      ensure          => 'present',
      enable          => true,
      active          => $active_content,
      service_restart => $service_restart,
      unit_entry      => {
        'Description'   => 'Apache Kafka server (broker)',
        'Documentation' => 'Documentation=http://kafka.apache.org/documentation.html',
        'After'         => $dependency_content,
        'Requires'      => $dependency_content,
      }.filter |$k, $v| { $v != undef },
      service_entry   => {
        'User'             => $user_name,
        'Group'            => $group_name,
        'SyslogIdentifier' => $service_name,
        'Environment'      => $environment,
        'ExecStart'        => $exec_start_content,
        'ExecStop'         => $exec_stop_content,
        'Restart'          => 'on-failure',
        'Type'             => $type_content,
        'LimitCORE'        => $limit_core,
        'LimitNOFILE'      => $limit_nofile,
        'TimeoutStopSec'   => $timeout_stop,
      }.filter |$k, $v| { $v != undef },
      install_entry   => {
        'WantedBy' => 'multi-user.target',
      },
    }
  }
}
