# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Define: kafka::topic
#
# This defined type is used to manage the creation of kafka topics.
#
define kafka::topic(
  $ensure             = '',
  $zookeeper          = '',
  $replication_factor = 1,
  $partitions         = 1,
  $bin_dir            = '/opt/kafka/bin',
) {

  $_zookeeper          = "--zookeeper ${zookeeper}"
  $_replication_factor = "--replication-factor ${replication_factor}"
  $_partitions         = "--partitions ${partitions}"

  if $ensure == 'present' {
    exec { "create topic ${name}":
      path    => "/usr/bin:/usr/sbin/:/bin:/sbin:${bin_dir}",
      command => "kafka-topics.sh --create ${_zookeeper} ${_replication_factor} ${_partitions} --topic ${name}",
      unless  => "kafka-topics.sh --list ${_zookeeper} | grep -x ${name}",
    }
  }
}
