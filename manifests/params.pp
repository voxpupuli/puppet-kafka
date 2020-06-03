# @summary
#   This class provides default parameters.
#
class kafka::params {
  unless $facts['os']['family'] =~ /(RedHat|Debian|Suse)/ {
    warning("${facts['os']['family']} is not supported")
  }

  $kafka_version  = '2.4.1'
  $scala_version  = '2.12'
  $install_dir    = "/opt/kafka-${scala_version}-${kafka_version}"
  $config_dir     = '/opt/kafka/config'
  $bin_dir        = '/opt/kafka/bin'
  $log_dir        = '/var/log/kafka'
  $mirror_url     = 'https://www.apache.org/dyn/closer.lua?action=download&filename='
  $mirror_subpath = "kafka/${kafka_version}"
  $manage_java    = false
  $package_dir    = '/var/tmp/kafka'
  $package_name   = undef
  $proxy_server   = undef
  $proxy_host     = undef
  $proxy_port     = undef
  $proxy_type     = undef
  $package_ensure = 'present'
  $user_name      = 'kafka'
  $user_shell     = '/sbin/nologin'
  $group_name     = 'kafka'
  $user_id        = undef
  $group_id       = undef
  $system_user    = false
  $system_group   = false
  $manage_user    = true
  $manage_group   = true
  $config_mode    = '0644'
  $install_mode   = '0755'

  $manage_service   = true
  $service_ensure   = 'running'
  $service_restart  = true
  $service_requires = ['network.target', 'syslog.target']
  $limit_nofile     = undef
  $limit_core       = undef
  $timeout_stop     = undef
  $exec_stop        = false
  $daemon_start     = false

  $broker_heap_opts  = '-Xmx1G -Xms1G'
  $broker_jmx_opts   = '-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9990'
  $broker_log4j_opts = "-Dlog4j.configuration=file:${config_dir}/log4j.properties"
  $broker_opts       = ''

  $mirror_heap_opts  = '-Xmx256M'
  $mirror_jmx_opts   = '-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9991'
  $mirror_log4j_opts = $broker_log4j_opts

  $producer_jmx_opts   = '-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9992'
  $producer_log4j_opts = $broker_log4j_opts

  $consumer_jmx_opts   = '-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9993'
  $consumer_log4j_opts = $broker_log4j_opts
}
