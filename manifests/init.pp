# @summary
#   This class handles the Kafka requirements.
#
# @example Basic usage
#   class { 'kafka': }
#
# @param kafka_version
#   The version of Kafka that should be installed.
#
# @param scala_version
#   The scala version what Kafka was built with.
#
# @param install_dir
#   The directory to install Kafka to.
#
# @param mirror_url
#   The url where the Kafka is downloaded from.
#
# @param manage_java
#   Install java if it's not already installed.
#
# @param package_dir
#   The directory to install Kafka.
#
# @param package_name
#   Package name, when installing Kafka from a package.
#
# @param mirror_subpath
#   The sub directory where the source is downloaded from.
#
# @param proxy_server
#   Set proxy server, when installing Kafka from source.
#
# @param proxy_port
#   Set proxy port, when installing Kafka from source.
#
# @param proxy_host
#   Set proxy host, when installing Kafka from source.
#
# @param proxy_type
#   Set proxy type, when installing Kafka from source.
#
# @param package_ensure
#   Package version or ensure state, when installing Kafka from a package.
#
# @param user_name
#   User to run Kafka as.
#
# @param user_shell
#   Login shell of the Kafka user.
#
# @param group_name
#   Group to run Kafka as.
#
# @param system_user
#   Whether the Kafka user is a system user or not.
#
# @param system_group
#   Whether the Kafka group is a system group or not.
#
# @param user_id
#   Create the Kafka user with this ID.
#
# @param group_id
#   Create the Kafka group with this ID.
#
# @param manage_user
#   Create the Kafka user if it's not already present.
#
# @param manage_group
#   Create the Kafka group if it's not already present.
#
# @param config_dir
#   The directory to create the Kafka config files to.
#
# @param log_dir
#   The directory for Kafka log files.
#
# @param install_mode
#   The permissions for the install directory.
#
class kafka (
  String[1] $kafka_version            = $kafka::params::kafka_version,
  String[1] $scala_version            = $kafka::params::scala_version,
  Stdlib::Absolutepath $install_dir   = $kafka::params::install_dir,
  Stdlib::HTTPUrl $mirror_url         = $kafka::params::mirror_url,
  Boolean $manage_java                = $kafka::params::manage_java,
  Stdlib::Absolutepath $package_dir   = $kafka::params::package_dir,
  Optional[String[1]] $package_name   = $kafka::params::package_name,
  Optional[String[1]] $mirror_subpath = $kafka::params::mirror_subpath,
  Optional[String[1]] $proxy_server   = $kafka::params::proxy_server,
  Optional[String[1]] $proxy_port     = $kafka::params::proxy_port,
  Optional[String[1]] $proxy_host     = $kafka::params::proxy_host,
  Optional[String[1]] $proxy_type     = $kafka::params::proxy_type,
  String[1] $package_ensure           = $kafka::params::package_ensure,
  String[1] $user_name                = $kafka::params::user_name,
  Stdlib::Absolutepath $user_shell    = $kafka::params::user_shell,
  String[1] $group_name               = $kafka::params::group_name,
  Boolean $system_user                = $kafka::params::system_user,
  Boolean $system_group               = $kafka::params::system_group,
  Optional[Integer] $user_id          = $kafka::params::user_id,
  Optional[Integer] $group_id         = $kafka::params::group_id,
  Boolean $manage_user                = $kafka::params::manage_user,
  Boolean $manage_group               = $kafka::params::manage_group,
  Stdlib::Absolutepath $config_dir    = $kafka::params::config_dir,
  Stdlib::Absolutepath $log_dir       = $kafka::params::log_dir,
  Stdlib::Filemode $install_mode      = $kafka::params::install_mode,
) inherits kafka::params {

  if $manage_java {
    class { 'java':
      distribution => 'jdk',
    }
  }

  if $manage_group {
    group { $group_name:
      ensure => present,
      gid    => $group_id,
      system => $system_group,
    }
  }

  if $manage_user {
    user { $user_name:
      ensure  => present,
      shell   => $user_shell,
      require => Group[$group_name],
      uid     => $user_id,
      system  => $system_user,
    }
  }

  file { $config_dir:
    ensure => directory,
    owner  => $user_name,
    group  => $group_name,
  }

  file { $log_dir:
    ensure  => directory,
    owner   => $user_name,
    group   => $group_name,
    require => [
      Group[$group_name],
      User[$user_name],
    ],
  }

  if $package_name == undef {
    include archive

    $mirror_path = $mirror_subpath ? {
      # if mirror_subpath was not changed,
      # we adapt it for the version
      $kafka::params::mirror_subpath => "kafka/${kafka_version}",
      # else, we just take whatever was supplied:
      default                        => $mirror_subpath,
    }

    $basefilename = "kafka_${scala_version}-${kafka_version}.tgz"
    $package_url = "${mirror_url}${mirror_path}/${basefilename}"

    $source = $mirror_url ?{
      /tgz$/ => $mirror_url,
      default  => $package_url,
    }

    $install_directory = $install_dir ? {
      # if install_dir was not changed,
      # we adapt it for the scala_version and the version
      $kafka::params::install_dir => "/opt/kafka-${scala_version}-${kafka_version}",
      # else, we just take whatever was supplied:
      default                     => $install_dir,
    }

    file { $package_dir:
      ensure  => directory,
      owner   => $user_name,
      group   => $group_name,
      require => [
        Group[$group_name],
        User[$user_name],
      ],
    }

    file { $install_directory:
      ensure  => directory,
      owner   => $user_name,
      group   => $group_name,
      mode    => $install_mode,
      require => [
        Group[$group_name],
        User[$user_name],
      ],
    }

    file { '/opt/kafka':
      ensure  => link,
      target  => $install_directory,
      require => File[$install_directory],
    }

    if $proxy_server == undef and $proxy_host != undef and $proxy_port != undef {
      $final_proxy_server = "${proxy_host}:${proxy_port}"
    } else {
      $final_proxy_server = $proxy_server
    }

    archive { "${package_dir}/${basefilename}":
      ensure          => present,
      extract         => true,
      extract_command => 'tar xfz %s --strip-components=1',
      extract_path    => $install_directory,
      source          => $source,
      creates         => "${install_directory}/config",
      cleanup         => true,
      proxy_server    => $final_proxy_server,
      proxy_type      => $proxy_type,
      user            => $user_name,
      group           => $group_name,
      require         => [
        File[$package_dir],
        File[$install_directory],
        Group[$group_name],
        User[$user_name],
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
