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

  $_onlyif_topicsconf  = "test `kafka-topics.sh --describe --topic ${name} ${_zookeeper} | grep -oE \"([a-z.]+)=([0-9]+)\" | while read; do echo \"${_config}\" | grep $REPLY && echo ok || echo ko; done|grep ko|head -1|wc -l` -ne 0"
  $_onlyif_topicsname  = "kafka-topics.sh --list ${_zookeeper} | grep -x ${name}"

  if $ensure == 'present' {
    exec { "create topic ${name}":
      path    => "/usr/bin:/usr/sbin/:/bin:/sbin:${bin_dir}",
      command => "kafka-topics.sh --create ${_zookeeper} ${_replication_factor} ${_partitions} --topic ${name} ${_config} || :",
      unless  => "${_onlyif_topicsname}",
    }

    exec { "update topic ${name}":
      path    => "/usr/bin:/usr/sbin/:/bin:/sbin:${bin_dir}",
      command => "kafka-topics.sh --alter ${_zookeeper} ${_partitions} --topic ${name} ${_config} || kafka-topics.sh --alter ${_zookeeper} --topic ${name} ${_config} || :",
      onlyif  => "${_onlyif_topicsname} && ${_onlyif_topicsconf}",
    }
  }

  if $ensure == 'absent' {
    exec { "delete topic ${name}":
      path    => "/usr/bin:/usr/sbin/:/bin:/sbin:${bin_dir}",
      command => "kafka-topics.sh --delete ${_zookeeper} --topic ${name} || :",
      onlyif  => "${_onlyif_topicsname}",
    }
  }
}
