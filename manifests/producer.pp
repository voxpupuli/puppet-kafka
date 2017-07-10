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
# [*env*]
# A hash of the environment variables to set.
#
# [*config*]
# A hash of the producer configuration options.
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
# [*user*]
# User to run kafka as.
#
# [*group*]
# Group to run kafka as.
#
# [*user_id*]
# Create kafka user with this ID.
#
# [*group_id*]
# Create kafka group with this ID.
#
# [*config_dir*]
# The directory to create the kafka config files to
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
  $version                          = $kafka::params::version,
  $scala_version                    = $kafka::params::scala_version,
  $install_dir                      = $kafka::params::install_dir,
  Stdlib::HTTPUrl $mirror_url       = $kafka::params::mirror_url,
  Hash $env                         = {},
  $config                           = {},
  $config_defaults                  = $kafka::params::producer_config_defaults,
  $service_config                   = {},
  $service_defaults                 = $kafka::params::producer_service_defaults,
  Boolean $install_java             = $kafka::params::install_java,
  Stdlib::Absolutepath $package_dir = $kafka::params::package_dir,
  Boolean $service_restart          = $kafka::params::service_restart,
  $service_requires_zookeeper       = $kafka::params::service_requires_zookeeper,
  $producer_jmx_opts                = $kafka::params::producer_jmx_opts,
  $producer_log4j_opts              = $kafka::params::producer_log4j_opts,
  $user                             = $kafka::params::user,
  $group                            = $kafka::params::group,
  $user_id                          = $kafka::params::user_id,
  $group_id                         = $kafka::params::group_id,
  $config_dir                       = $kafka::params::config_dir,
  Stdlib::Absolutepath $bin_dir     = $kafka::params::bin_dir,
) inherits kafka::params {

  class { '::kafka::producer::install': }
  -> class { '::kafka::producer::config': }
  -> class { '::kafka::producer::service': }
  -> Class['kafka::producer']
}
