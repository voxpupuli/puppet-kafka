# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Define: kafka::topic
#
# This defined type is used to manage the creation of kafka topics.
#
define kafka::topic(
  String                        $ensure             = '',
  String                        $zookeeper          = '',
  Variant[Integer,String]       $replication_factor = 1,
  Variant[Integer,String]       $partitions         = 1,
  String                        $bin_dir            = '/opt/kafka/bin',
  Optional[Hash[String,String]] $config             = undef,
) {

  if is_string($replication_factor) {
    deprication('kafka::topic', 'Please use Integer type, not String, for paramter replication_factor')
  }
  if is_string($partitions) {
    deprication('kafka::topic', 'Please use Integer type, not String, for paramter partitions')
  }

  $_zookeeper          = "--zookeeper ${zookeeper}"
  $_replication_factor = "--replication-factor ${replication_factor}"
  $_partitions         = "--partitions ${partitions}"

  if $config {
    $_config_array = $config.map |$key, $value| { "--config ${key}=${value}" }
    $_config = join($_config_array, ' ')
  } else {
    $_config = ''
  }

  if $ensure == 'present' {
    exec { "create topic ${name}":
      path    => "/usr/bin:/usr/sbin/:/bin:/sbin:${bin_dir}",
      command => "kafka-topics.sh --create ${_zookeeper} ${_replication_factor} ${_partitions} --topic ${name} ${_config}",
      unless  => "kafka-topics.sh --list ${_zookeeper} | grep -x ${name}",
    }

    exec { "update topic ${name}":
      path    => "/usr/bin:/usr/sbin/:/bin:/sbin:${bin_dir}",
      command => "kafka-topics.sh --alter ${_zookeeper} ${_partitions} --topic ${name} ${_config}",
      onlyif  => "kafka-topics.sh --list ${_zookeeper} | grep -x ${name}",
    }
  }

  if $ensure == 'absent' {
    exec { "delete topic ${name}":
      path    => "/usr/bin:/usr/sbin/:/bin:/sbin:${bin_dir}",
      command => "kafka-topics.sh --delete ${_zookeeper} --topic ${name}",
      onlyif  => "kafka-topics.sh --list ${_zookeeper} | grep -x ${name}",
    }
  }

}
