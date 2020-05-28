# @summary
#   This class handles the Kafka (mirror) service.
#
# @api private
#
class kafka::mirror::service(
  Boolean $manage_service                    = $kafka::mirror::manage_service,
  Enum['running', 'stopped'] $service_ensure = $kafka::mirror::service_ensure,
  String[1] $service_name                    = $kafka::mirror::service_name,
  String[1] $user_name                       = $kafka::mirror::user_name,
  String[1] $group_name                      = $kafka::mirror::group_name,
  Stdlib::Absolutepath $config_dir           = $kafka::mirror::config_dir,
  Stdlib::Absolutepath $log_dir              = $kafka::mirror::log_dir,
  Stdlib::Absolutepath $bin_dir              = $kafka::mirror::bin_dir,
  Array[String[1]] $service_requires         = $kafka::mirror::service_requires,
  Optional[String[1]] $limit_nofile          = $kafka::mirror::limit_nofile,
  Optional[String[1]] $limit_core            = $kafka::mirror::limit_core,
  Hash $env                                  = $kafka::mirror::env,
  Hash[String[1],String[1]] $consumer_config = $kafka::mirror::consumer_config,
  Hash[String[1],String[1]] $producer_config = $kafka::mirror::producer_config,
  Hash[String[1],String[1]] $service_config  = $kafka::mirror::service_config,
  String[1] $heap_opts                       = $kafka::mirror::heap_opts,
  String[1] $jmx_opts                        = $kafka::mirror::jmx_opts,
  String[1] $log4j_opts                      = $kafka::mirror::log4j_opts,
) {

  assert_private()

  if $manage_service {
    $env_defaults = {
      'KAFKA_HEAP_OPTS'  => $heap_opts,
      'KAFKA_JMX_OPTS'   => $jmx_opts,
      'KAFKA_LOG4J_OPTS' => $log4j_opts,
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
