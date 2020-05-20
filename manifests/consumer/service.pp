# @summary
#   This class handles the Kafka (consumer) service.
#
# @api private
#
class kafka::consumer::service(
  Boolean $manage_service                    = $kafka::consumer::manage_service,
  Enum['running', 'stopped'] $service_ensure = $kafka::consumer::service_ensure,
  String[1] $service_name                    = $kafka::consumer::service_name,
  String[1] $user_name                       = $kafka::consumer::user_name,
  String[1] $group_name                      = $kafka::consumer::group_name,
  Stdlib::Absolutepath $config_dir           = $kafka::consumer::config_dir,
  Stdlib::Absolutepath $log_dir              = $kafka::consumer::log_dir,
  Stdlib::Absolutepath $bin_dir              = $kafka::consumer::bin_dir,
  Array[String[1]] $service_requires         = $kafka::consumer::service_requires,
  Optional[String[1]] $limit_nofile          = $kafka::consumer::limit_nofile,
  Optional[String[1]] $limit_core            = $kafka::consumer::limit_core,
  Hash $env                                  = $kafka::consumer::env,
  String[1] $jmx_opts                        = $kafka::consumer::jmx_opts,
  String[1] $log4j_opts                      = $kafka::consumer::log4j_opts,
  Hash[String[1],String[1]] $service_config  = $kafka::consumer::service_config,
) {

  assert_private()

  if $manage_service {

    if $service_config['topic'] == '' {
      fail('[Consumer] You need to specify a value for topic')
    }
    if $service_config['zookeeper'] == '' {
      fail('[Consumer] You need to specify a value for zookeeper')
    }

    $env_defaults = {
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
