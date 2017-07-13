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
# [*env*]
# A hash of the environment variables to set.
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
# Create the mirror service connecting to a local zookeeper
#
# class { 'kafka::mirror':
#  consumer_config => { 'client.id' => '0', 'zookeeper.connect' => 'localhost:2181' }
# }
#
class kafka::mirror (
  $version                              = $kafka::params::version,
  $scala_version                        = $kafka::params::scala_version,
  $install_dir                          = $kafka::params::install_dir,
  Stdlib::HTTPUrl $mirror_url           = $kafka::params::mirror_url,
  Hash $env                             = {},
  $consumer_config                      = {},
  $consumer_config_defaults             = $kafka::params::consumer_config_defaults,
  $producer_config                      = {},
  $producer_config_defaults             = $kafka::params::producer_config_defaults,
  Integer $num_streams                  = $kafka::params::num_streams,
  Integer $num_producers                = $kafka::params::num_producers,
  Boolean $abort_on_send_failure        = $kafka::params::abort_on_send_failure,
  Boolean $install_java                 = $kafka::params::install_java,
  Integer $limit_nofile                 = $kafka::params::limit_nofile,
  $whitelist                            = $kafka::params::whitelist,
  $blacklist                            = $kafka::params::blacklist,
  Pattern[/\d+[g|G|m|M|k|K]/] $max_heap = $kafka::params::mirror_max_heap,
  Stdlib::Absolutepath $package_dir     = $kafka::params::package_dir,
  Boolean $service_restart              = $kafka::params::service_restart,
  $service_requires_zookeeper           = $kafka::params::service_requires_zookeeper,
  $mirror_jmx_opts                      = $kafka::params::mirror_jmx_opts,
  $mirror_log4j_opts                    = $kafka::params::mirror_log4j_opts,
  String $user                          = $kafka::params::user,
  String $group                         = $kafka::params::group,
  Optional[Integer] $user_id            = $kafka::params::user_id,
  Optional[Integer] $group_id           = $kafka::params::group_id,
  $config_dir                           = $kafka::params::config_dir,
  Stdlib::Absolutepath $bin_dir         = $kafka::params::bin_dir,
) inherits kafka::params {

  class { '::kafka::mirror::install': }
  -> class { '::kafka::mirror::config': }
  -> class { '::kafka::mirror::service': }
  -> Class['kafka::mirror']
}
