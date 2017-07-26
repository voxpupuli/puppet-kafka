# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::producer
#
# This class will install kafka with the producer role.
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
# [*install_java*]
# Install java if it's not already installed.
#
# [*package_dir*]
# The directory to install kafka.
#
# [*package_name*]
# Package name, when installing kafka from a package.
#
# [*package_ensure*]
# Package version (or 'present', 'absent', 'latest'), when installing kafka from a package.
#
# [*user*]
# User to run kafka as.
#
# [*group*]
# Group to run kafka as.
#
# [*user_id*]
# Create the kafka user with this ID.
#
# [*group_id*]
# Create the kafka group with this ID.
#
# [*manage_user*]
# Create the kafka user if it's not already present.
#
# [*manage_group*]
# Create the kafka group if it's not already present.
#
# [*config_dir*]
# The directory to create the kafka config files to.
#
# [*log_dir*]
# The directory for kafka log files.
#
# [*env*]
# A hash of the environment variables to set.
#
# [*config*]
# A hash of the producer configuration options.
#
# [*service_restart*]
# Boolean, if the configuration files should trigger a service restart
#
# [*bin_dir*]
# The directory where the kafka scripts are
#
# === Examples
#
# Create the producer service connecting to a local zookeeper
#
# class { 'kafka::producer':
#  config => { 'client.id' => '0', 'zookeeper.connect' => 'localhost:2181' }
# }
#
class kafka::producer (
  $input,
  String $version                     = $kafka::params::version,
  String $scala_version               = $kafka::params::scala_version,
  Stdlib::Absolutepath $install_dir   = $kafka::params::install_dir,
  Stdlib::HTTPUrl $mirror_url         = $kafka::params::mirror_url,
  Boolean $install_java               = $kafka::params::install_java,
  Stdlib::Absolutepath $package_dir   = $kafka::params::package_dir,
  Optional[String] $package_name      = $kafka::params::package_name,
  String $package_ensure              = $kafka::params::package_ensure,
  String $user                        = $kafka::params::user,
  String $group                       = $kafka::params::group,
  Optional[Integer] $user_id          = $kafka::params::user_id,
  Optional[Integer] $group_id         = $kafka::params::group_id,
  Boolean $manage_user                = $kafka::params::manage_user,
  Boolean $manage_group               = $kafka::params::manage_group,
  Stdlib::Absolutepath $config_dir    = $kafka::params::config_dir,
  Stdlib::Absolutepath $log_dir       = $kafka::params::log_dir,
  Hash $env                           = {},
  Hash $config                        = {},
  Hash $config_defaults               = $kafka::params::producer_config_defaults,
  Hash $service_config                = {},
  Hash $service_defaults              = $kafka::params::producer_service_defaults,
  Boolean $service_restart            = $kafka::params::service_restart,
  Boolean $service_requires_zookeeper = $kafka::params::service_requires_zookeeper,
  $producer_jmx_opts                  = $kafka::params::producer_jmx_opts,
  $producer_log4j_opts                = $kafka::params::producer_log4j_opts,
  Stdlib::Absolutepath $bin_dir       = $kafka::params::bin_dir,
) inherits kafka::params {

  class { '::kafka::producer::install': }
  -> class { '::kafka::producer::config': }
  -> class { '::kafka::producer::service': }
  -> Class['kafka::producer']
}
