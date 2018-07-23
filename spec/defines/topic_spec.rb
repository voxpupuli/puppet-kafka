require 'spec_helper'

describe 'kafka::topic', type: :define do
  let :facts do
    {
      osfamily: 'Debian',
      operatingsystem: 'Ubuntu',
      operatingsystemrelease: '14.04',
      lsbdistcodename: 'trusty',
      architecture: 'amd64'
    }
  end
  let(:title) { 'demo' }

  context 'on Debian' do
    context 'when create topic demo' do
      let :params do
        {
          'ensure'             => 'present',
          'zookeeper'          => 'localhost:2181',
          'replication_factor' => '1',
          'partitions'         => '1'
        }
      end

      it {
        is_expected.to contain_exec('create topic demo').with(
          command: 'kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic demo '
        )
      }
    end
    context 'when create topic with config' do
      let :params do
        {
          'ensure'             => 'present',
          'zookeeper'          => 'localhost:2181',
          'replication_factor' => 1,
          'partitions'         => 1,
          'config'             => { 'cleanup.policy' => 'compact', 'retention.ms' => '2592000000' }
        }
      end

      it {
        is_expected.to contain_exec('create topic demo').with(
          command: 'kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic demo --config cleanup.policy=compact --config retention.ms=2592000000'
        )
      }
    end
  end
end
