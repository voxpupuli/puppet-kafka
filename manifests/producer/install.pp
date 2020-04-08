# @summary
#   This class handles the Kafka (producer) package.
#
# @api private
#
class kafka::producer::install {

  assert_private()

  if !defined(Class['kafka']) {
    class { 'kafka':
      version        => $kafka::producer::version,
      scala_version  => $kafka::producer::scala_version,
      install_dir    => $kafka::producer::install_dir,
      mirror_url     => $kafka::producer::mirror_url,
      install_java   => $kafka::producer::install_java,
      package_dir    => $kafka::producer::package_dir,
      package_name   => $kafka::producer::package_name,
      package_ensure => $kafka::producer::package_ensure,
      user           => $kafka::producer::user,
      group          => $kafka::producer::group,
      user_id        => $kafka::producer::user_id,
      group_id       => $kafka::producer::group_id,
      manage_user    => $kafka::producer::manage_user,
      manage_group   => $kafka::producer::manage_group,
      config_dir     => $kafka::producer::config_dir,
      log_dir        => $kafka::producer::log_dir,
    }
  }
}
