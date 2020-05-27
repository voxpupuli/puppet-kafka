require 'spec_helper'

describe 'kafka::topic', type: :define do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
      end

      context 'when create topic demo' do
        let(:title) { 'demo' }
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

      context 'when create topic demo with config' do
        let(:title) { 'demo' }
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
end
