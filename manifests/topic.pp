# @summary
#   This defined type handles the creation of Kafka topics.
#
# @example Basic usage
#   kafka::topic { 'test':
#     ensure             => present,
#     zookeeper          => 'localhost:2181',
#     replication_factor => 1,
#     partitions         => 1,
#   }
#
# @param ensure
#   Should the topic be created.
#
# @param zookeeper
#   The connection string for the ZooKeeper connection in the form host:port.
#   Multiple hosts can be given to allow fail-over.
#
# @param replication_factor
#   The replication factor for each partition in the topic being created. If
#   not supplied, defaults to the cluster default.
#
# @param partitions
#   The number of partitions for the topic being created or altered. If not
#   supplied for create, defaults to the cluster default.
#
# @param bin_dir
#   The directory where the file kafka-topics.sh is located.
#
# @param config
#   A topic configuration override for the topic being created or altered.
#   See the Kafka documentation for full details on the topic configs.
#
define kafka::topic(
  String[1] $ensure                              = '',
  String[1] $zookeeper                           = '',
  Variant[Integer,String[1]] $replication_factor = 1,
  Variant[Integer,String[1]] $partitions         = 1,
  String[1] $bin_dir                             = '/opt/kafka/bin',
  Optional[Hash[String[1],String[1]]] $config    = undef,
) {

  if is_string($replication_factor) {
    deprecation('kafka::topic', 'Please use Integer type, not String, for paramter replication_factor')
  }
  if is_string($partitions) {
    deprecation('kafka::topic', 'Please use Integer type, not String, for paramter partitions')
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
  }
}
