# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::mirror::install
#
# This private class is meant to be called from `kafka::mirror`.
# It downloads the package and installs it.
#
class kafka::mirror::install {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if !defined(Class['::kafka']) {
    class { '::kafka':
      version        => $kafka::mirror::version,
      scala_version  => $kafka::mirror::scala_version,
      install_dir    => $kafka::mirror::install_dir,
      mirror_url     => $kafka::mirror::mirror_url,
      install_java   => $kafka::mirror::install_java,
      package_dir    => $kafka::mirror::package_dir,
      package_name   => $kafka::mirror::package_name,
      package_ensure => $kafka::mirror::package_ensure,
      user           => $kafka::mirror::user,
      group          => $kafka::mirror::group,
      user_id        => $kafka::mirror::user_id,
      group_id       => $kafka::mirror::group_id,
      manage_user    => $kafka::mirror::manage_user,
      manage_group   => $kafka::mirror::manage_group,
      config_dir     => $kafka::mirror::config_dir,
      log_dir        => $kafka::mirror::log_dir,
    }
  }
}
