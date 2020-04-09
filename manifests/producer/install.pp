# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::producer::install
#
# This private class is meant to be called from `kafka::producer`.
# It downloads the package and installs it.
#
class kafka::producer::install {

  assert_private()

  if !defined(Class['kafka']) {
    class { 'kafka':
      kafka_version  => $kafka::producer::kafka_version,
      scala_version  => $kafka::producer::scala_version,
      install_dir    => $kafka::producer::install_dir,
      mirror_url     => $kafka::producer::mirror_url,
      install_java   => $kafka::producer::install_java,
      package_dir    => $kafka::producer::package_dir,
      package_name   => $kafka::producer::package_name,
      package_ensure => $kafka::producer::package_ensure,
      user_name      => $kafka::producer::user_name,
      group_name     => $kafka::producer::group_name,
      user_id        => $kafka::producer::user_id,
      group_id       => $kafka::producer::group_id,
      manage_user    => $kafka::producer::manage_user,
      manage_group   => $kafka::producer::manage_group,
      config_dir     => $kafka::producer::config_dir,
      log_dir        => $kafka::producer::log_dir,
    }
  }
}
