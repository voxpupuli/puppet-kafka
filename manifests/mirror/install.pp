# @summary
#   This class handles the Kafka (mirror) package.
#
# @api private
#
class kafka::mirror::install {

  assert_private()

  if !defined(Class['kafka']) {
    class { 'kafka':
      manage_java    => $kafka::mirror::manage_java,
      manage_group   => $kafka::mirror::manage_group,
      group_id       => $kafka::mirror::group_id,
      group_name     => $kafka::mirror::group_name,
      manage_user    => $kafka::mirror::manage_user,
      user_id        => $kafka::mirror::user_id,
      user_name      => $kafka::mirror::user_name,
      user_shell     => $kafka::mirror::user_shell,
      config_dir     => $kafka::mirror::config_dir,
      log_dir        => $kafka::mirror::log_dir,
      mirror_url     => $kafka::mirror::mirror_url,
      kafka_version  => $kafka::mirror::kafka_version,
      scala_version  => $kafka::mirror::scala_version,
      install_dir    => $kafka::mirror::install_dir,
      package_dir    => $kafka::mirror::package_dir,
      package_ensure => $kafka::mirror::package_ensure,
      package_name   => $kafka::mirror::package_name,
    }
  }
}
