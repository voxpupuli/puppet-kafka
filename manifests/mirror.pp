# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::mirror
#
# This class will install kafka with the mirror role.
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
# [*consumer_config*]
# A hash of the consumer configuration options.
#
# [*producer_config*]
# A hash of the producer configuration options.
#
# [*num_streams*]
# Number of stream (consumer) threads to start.
#
# [*num_producers*]
# Number of producer threads to start.
#
# [*abort_on_send_failure*]
# Abort immediately if MirrorMaker fails to send to receiving cluster
#
# [*install_java*]
# Install java if it's not already installed.
#
# [*max_heap*]
# Max heap size passed to java with -Xmx (<size>[g|G|m|M|k|K])
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
# Create the mirror service connecting to a local zookeeper
#
# class { 'kafka::mirror':
#  consumer_config => { 'client.id' => '0', 'zookeeper.connect' => 'localhost:2181' }
# }
#
class kafka::mirror (
  $version                    = $kafka::params::version,
  $scala_version              = $kafka::params::scala_version,
  $install_dir                = $kafka::params::install_dir,
  $mirror_url                 = $kafka::params::mirror_url,
  $consumer_config            = {},
  $consumer_config_defaults   = $kafka::params::consumer_config_defaults,
  $producer_config            = {},
  $producer_config_defaults   = $kafka::params::producer_config_defaults,
  $num_streams                = $kafka::params::num_streams,
  $num_producers              = $kafka::params::num_producers,
  $abort_on_send_failure      = $kafka::params::abort_on_send_failure,
  $install_java               = $kafka::params::install_java,
  $whitelist                  = $kafka::params::whitelist,
  $blacklist                  = $kafka::params::blacklist,
  $max_heap                   = $kafka::params::mirror_max_heap,
  $package_dir                = $kafka::params::package_dir,
  $service_restart            = $kafka::params::service_restart,
  $service_requires_zookeeper = $kafka::params::service_requires_zookeeper,
  $mirror_jmx_opts            = $kafka::params::mirror_jmx_opts,
  $mirror_log4j_opts          = $kafka::params::mirror_log4j_opts,
  $config_dir                 = $kafka::params::config_dir,
) inherits kafka::params {

  validate_re($::osfamily, 'RedHat|Debian\b', "${::operatingsystem} not supported")
  validate_re($mirror_url, $kafka::params::mirror_url_regex, "${mirror_url} is not a valid url")
  validate_integer($num_streams)
  validate_integer($num_producers)
  validate_bool($abort_on_send_failure)
  validate_bool($install_java)
  validate_re($max_heap, '\d+[g|G|m|M|k|K]', "${max_heap} is not a valid heap size")
  validate_absolute_path($package_dir)
  validate_bool($service_restart)

  class { '::kafka::mirror::install': } ->
  class { '::kafka::mirror::config': } ->
  class { '::kafka::mirror::service': } ->
  Class['kafka::mirror']
}
