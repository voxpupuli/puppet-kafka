require 'spec_helper'

describe 'kafka::broker::topic', type: :define do
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

      it { is_expected.to contain_exec('create topic demo') }
    end
  end
end
