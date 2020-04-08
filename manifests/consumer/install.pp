# @summary
#   This class handles the Kafka (consumer) package.
#
# @api private
#
class kafka::consumer::install {

  assert_private()

  if !defined(Class['kafka']) {
    class { 'kafka':
      version        => $kafka::consumer::version,
      scala_version  => $kafka::consumer::scala_version,
      install_dir    => $kafka::consumer::install_dir,
      mirror_url     => $kafka::consumer::mirror_url,
      install_java   => $kafka::consumer::install_java,
      package_dir    => $kafka::consumer::package_dir,
      package_name   => $kafka::consumer::package_name,
      package_ensure => $kafka::consumer::package_ensure,
      user           => $kafka::consumer::user,
      group          => $kafka::consumer::group,
      user_id        => $kafka::consumer::user_id,
      group_id       => $kafka::consumer::group_id,
      manage_user    => $kafka::consumer::manage_user,
      manage_group   => $kafka::consumer::manage_group,
      config_dir     => $kafka::consumer::config_dir,
      log_dir        => $kafka::consumer::log_dir,
    }
  }
}
