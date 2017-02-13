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
# [*config_dir*]
# The directory to create the kafka config files to
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
  $version                    = $kafka::params::version,
  $scala_version              = $kafka::params::scala_version,
  $install_dir                = $kafka::params::install_dir,
  $mirror_url                 = $kafka::params::mirror_url,
  $config                     = {},
  $config_defaults            = $kafka::params::producer_config_defaults,
  $service_config             = {},
  $service_defaults           = $kafka::params::producer_service_defaults,
  $install_java               = $kafka::params::install_java,
  $package_dir                = $kafka::params::package_dir,
  $service_restart            = $kafka::params::service_restart,
  $service_requires_zookeeper = $kafka::params::service_requires_zookeeper,
  $producer_jmx_opts          = $kafka::params::producer_jmx_opts,
  $producer_log4j_opts        = $kafka::params::producer_log4j_opts,
  $config_dir                 = $kafka::params::config_dir,
) inherits kafka::params {

  validate_re($::osfamily, 'RedHat|Debian\b', "${::operatingsystem} not supported")
  validate_re($mirror_url, $kafka::params::mirror_url_regex, "${mirror_url} is not a valid url")
  validate_bool($install_java)
  validate_absolute_path($package_dir)
  validate_bool($service_restart)

  class { '::kafka::producer::install': } ->
  class { '::kafka::producer::config': } ->
  class { '::kafka::producer::service': } ->
  Class['kafka::producer']
}
