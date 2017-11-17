# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class kafka::params
#
# This class is meant to be called from kafka::broker
# It sets variables according to platform
#
class kafka::params {

  # this is all only tested on Debian and RedHat
  # params gets included everywhere so we can do the validation here
  unless $facts['os']['family'] =~ /(RedHat|Debian)/ {
    warning("${facts['os']['family']} is not supported")
  }
  $version        = '0.11.0.1'
  $scala_version  = '2.11'
  $install_dir    = "/opt/kafka-${scala_version}-${version}"
  $config_dir     = '/opt/kafka/config'
  $bin_dir        = '/opt/kafka/bin'
  $log_dir        = '/var/log/kafka'
  $mirror_url     = 'http://mirrors.ukfast.co.uk/sites/ftp.apache.org'
  $install_java   = false
  $package_dir    = '/var/tmp/kafka'
  $package_name   = undef
  $package_ensure = 'present'
  $user           = 'kafka'
  $group          = 'kafka'
  $user_id        = undef
  $group_id       = undef
  $system_user    = false
  $system_group   = false
  $manage_user    = true
  $manage_group   = true

  $service_install = true
  $service_ensure = 'running'
  $service_restart = true
  $service_requires = $facts['os']['family'] ? {
    'RedHat' => ['network.target', 'syslog.target'],
    default  => [],
  }
  $limit_nofile = undef
  $limit_core = undef
  $timeout_stop = undef
  $exec_stop = false
  $daemon_start = false

  $broker_heap_opts  = '-Xmx1G -Xms1G'
  $broker_jmx_opts   = '-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false \
  -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9990'
  $broker_log4j_opts = "-Dlog4j.configuration=file:${config_dir}/log4j.properties"
  $broker_opts       = ''

  $mirror_heap_opts  = '-Xmx256M'
  $mirror_jmx_opts   = '-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false \
  -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9991'
  $mirror_log4j_opts = $broker_log4j_opts

  $producer_jmx_opts   = '-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false \
  -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9992'
  $producer_log4j_opts = $broker_log4j_opts

  $consumer_jmx_opts   = '-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false \
  -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9993'
  $consumer_log4j_opts = $broker_log4j_opts

}
