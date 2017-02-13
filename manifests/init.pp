# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka
#
# This class will install kafka binaries
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
# [*group_id*]
# Create kafka group with this ID
#
# [*user_id*]
# Create kafka user with this ID
#
# [*config_dir*]
# The directory to create the kafka config files to
#
# === Examples
#
#
class kafka (
  $version        = $kafka::params::version,
  $scala_version  = $kafka::params::scala_version,
  $install_dir    = $kafka::params::install_dir,
  $mirror_url     = $kafka::params::mirror_url,
  $install_java   = $kafka::params::install_java,
  $package_dir    = $kafka::params::package_dir,
  $package_name   = $kafka::params::package_name,
  $package_ensure = $kafka::params::package_ensure,
  $group_id       = $kafka::params::group_id,
  $user_id        = $kafka::params::user_id,
  $config_dir     = $kafka::params::config_dir,
) inherits kafka::params {

  validate_re($::osfamily, 'RedHat|Debian\b', "${::operatingsystem} not supported")
  validate_bool($install_java)
  validate_absolute_path($package_dir)

  $basefilename = "kafka_${scala_version}-${version}.tgz"
  $package_url = "${mirror_url}/kafka/${version}/${basefilename}"

  $source = $mirror_url ?{
    /tgz$/ => $mirror_url,
    default  => $package_url,
  }

  $install_directory = $install_dir ? {
    # if install_dir was not changed,
    # we adapt it for the scala_version and the version
    $kafka::params::install_dir => "/opt/kafka-${scala_version}-${version}",
    # else, we just take whatever was supplied:
    default                     => $install_dir,
  }

  if $install_java {
    class { '::java':
      distribution => 'jdk',
    }
  }

  group { 'kafka':
    ensure => present,
    gid    => $group_id,
  }

  user { 'kafka':
    ensure  => present,
    shell   => '/bin/bash',
    require => Group['kafka'],
    uid     => $user_id,
  }

  file { $package_dir:
    ensure  => directory,
    owner   => 'kafka',
    group   => 'kafka',
    require => [
      Group['kafka'],
      User['kafka'],
    ],
  }

  file { $install_directory:
    ensure  => directory,
    owner   => 'kafka',
    group   => 'kafka',
    require => [
      Group['kafka'],
      User['kafka'],
    ],
  }

  file { '/opt/kafka':
    ensure  => link,
    target  => $install_directory,
    require => File[$install_directory],
  }

  file { $config_dir:
    ensure => directory,
    owner  => 'kafka',
    group  => 'kafka',
  }

  file { '/var/log/kafka':
    ensure  => directory,
    owner   => 'kafka',
    group   => 'kafka',
    require => [
      Group['kafka'],
      User['kafka'],
    ],
  }

  if $package_name == undef {
    include '::archive'

    archive { "${package_dir}/${basefilename}":
      ensure          => present,
      extract         => true,
      extract_command => 'tar xfz %s --strip-components=1',
      extract_path    => $install_directory,
      source          => $source,
      creates         => "${install_directory}/config",
      cleanup         => true,
      user            => 'kafka',
      group           => 'kafka',
      require         => [
        File[$package_dir],
        File[$install_directory],
        Group['kafka'],
        User['kafka'],
      ],
      before          => File[$config_dir],
    }
  } else {
    package { $package_name:
      ensure => $package_ensure,
      before => File[$config_dir],
    }
  }
}
