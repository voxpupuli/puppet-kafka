# @summary
#   This class handles the Kafka (broker) service.
#
# @api private
#
class kafka::broker::service(
  Boolean $manage_service                    = $kafka::broker::manage_service,
  Enum['running', 'stopped'] $service_ensure = $kafka::broker::service_ensure,
  String[1] $service_name                    = $kafka::broker::service_name,
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
    $environment = deep_merge($env_defaults, $env)

    if $facts['service_provider'] == 'systemd' {
      include systemd

      file { "/etc/systemd/system/${service_name}.service":
        ensure  => file,
        mode    => '0644',
        content => template('kafka/unit.erb'),
      }

      file { "/etc/init.d/${service_name}":
        ensure => absent,
      }

      File["/etc/systemd/system/${service_name}.service"]
      ~> Exec['systemctl-daemon-reload']
      -> Service[$service_name]
    } else {
      file { "/etc/init.d/${service_name}":
        ensure  => file,
        mode    => '0755',
        content => template('kafka/init.erb'),
        before  => Service[$service_name],
      }
    }

    service { $service_name:
      ensure     => $service_ensure,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
