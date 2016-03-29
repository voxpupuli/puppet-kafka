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
# === Examples
#
#
class kafka (
  $version       = $kafka::params::version,
  $scala_version = $kafka::params::scala_version,
  $install_dir   = $kafka::params::install_dir,
  $mirror_url    = $kafka::params::mirror_url,
  $install_java  = $kafka::params::install_java,
  $package_dir   = $kafka::params::package_dir
) inherits kafka::params {

  validate_re($::osfamily, 'RedHat|Debian\b', "${::operatingsystem} not supported")
  validate_re($mirror_url, '^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$', "${mirror_url} is not a valid url")
  validate_bool($install_java)
  validate_absolute_path($package_dir)

  $basefilename = "kafka_${scala_version}-${version}.tgz"
  $package_url = "${mirror_url}/kafka/${version}/${basefilename}"

  if $version != $kafka::params::version {
    $install_directory = "/opt/kafka-${scala_version}-${version}"
  } elsif $scala_version != $kafka::params::scala_version {
    $install_directory = "/opt/kafka-${scala_version}-${version}"
  } else {
    $install_directory = $install_dir
  }

  if $install_java {
    class { '::java':
      distribution => 'jdk',
    }
  }

  group { 'kafka':
    ensure => present,
  }

  user { 'kafka':
    ensure  => present,
    shell   => '/bin/bash',
    require => Group['kafka'],
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

  file { '/opt/kafka/config':
    ensure  => directory,
    owner   => 'kafka',
    group   => 'kafka',
    require => Archive["${package_dir}/${basefilename}"],
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

  include '::archive'

  archive { "${package_dir}/${basefilename}":
    ensure          => present,
    extract         => true,
    extract_command => 'tar xfz %s --strip-components=1',
    extract_path    => $install_directory,
    source          => $package_url,
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
  }
}
