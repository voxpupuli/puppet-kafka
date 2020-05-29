# @summary
#   This class handles the Kafka (producer) package.
#
# @api private
#
class kafka::producer::install {

  assert_private()

  if !defined(Class['kafka']) {
    class { 'kafka':
      manage_java    => $kafka::producer::manage_java,
      manage_group   => $kafka::producer::manage_group,
      group_id       => $kafka::producer::group_id,
      group_name     => $kafka::producer::group_name,
      manage_user    => $kafka::producer::manage_user,
      user_id        => $kafka::producer::user_id,
      user_name      => $kafka::producer::user_name,
      user_shell     => $kafka::producer::user_shell,
      config_dir     => $kafka::producer::config_dir,
      log_dir        => $kafka::producer::log_dir,
      mirror_url     => $kafka::producer::mirror_url,
      kafka_version  => $kafka::producer::kafka_version,
      scala_version  => $kafka::producer::scala_version,
      install_dir    => $kafka::producer::install_dir,
      package_dir    => $kafka::producer::package_dir,
      package_ensure => $kafka::producer::package_ensure,
      package_name   => $kafka::producer::package_name,
    }
  }
}
