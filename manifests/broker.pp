# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::broker
#
# This class will install kafka with the broker role.
#
# === Requirements/Dependencies
#
# Currently requires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*version*]
# The version of kafka that should be installed.
#
# [*scala_version*]
# The scala version what kafka was built with.
#
# [*install_dir*]
# The directory to install kafka to.
#
# [*mirror_url*]
# The url where the kafka is downloaded from.
#
# [*config*]
# A hash of the configuration options.
#
# [*install_java*]
# Install java if it's not already installed.
#
# [*package_dir*]
# The directory to install kafka.
#
# [*service_restart*]
# Boolean, if the configuration files should trigger a service restart
#
# [*config_dir*]
# The directory to create the kafka config files to
#
# [*bin_dir*]
# The directory where the kafka scripts are
#
# === Examples
#
# Create a single broker instance which talks to a local zookeeper instance.
#
# class { 'kafka::broker':
#  config => { 'broker.id' => '0', 'zookeeper.connect' => 'localhost:2181' }
# }
#
class kafka::broker (
  $version                                   = $kafka::params::version,
  $scala_version                             = $kafka::params::scala_version,
  $install_dir                               = $kafka::params::install_dir,
  Stdlib::HTTPUrl $mirror_url                = $kafka::params::mirror_url,
  Hash $config                               = {},
  $config_defaults                           = $kafka::params::broker_config_defaults,
  Boolean $install_java                      = $kafka::params::install_java,
  Integer $limit_nofile                      = $kafka::params::limit_nofile,
  Stdlib::Absolutepath $package_dir          = $kafka::params::package_dir,
  Boolean $service_install                   = $kafka::params::broker_service_install,
  Enum['running', 'stopped'] $service_ensure = $kafka::params::broker_service_ensure,
  Boolean $service_restart                   = $kafka::params::service_restart,
  $service_requires_zookeeper                = $kafka::params::service_requires_zookeeper,
  $jmx_opts                                  = $kafka::params::broker_jmx_opts,
  $heap_opts                                 = $kafka::params::broker_heap_opts,
  $log4j_opts                                = $kafka::params::broker_log4j_opts,
  $opts                                      = $kafka::params::broker_opts,
  $group_id                                  = $kafka::params::group_id,
  $user_id                                   = $kafka::params::user_id,
  $config_dir                                = $kafka::params::config_dir,
  Stdlib::Absolutepath $bin_dir              = $kafka::params::bin_dir,
  $log_dir                                   = $kafka::params::log_dir,
) inherits kafka::params {

  class { '::kafka::broker::install': }
  -> class { '::kafka::broker::config': }
  -> class { '::kafka::broker::service': }
  -> Class['kafka::broker']
}
