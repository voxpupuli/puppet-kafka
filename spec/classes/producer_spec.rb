require 'spec_helper'
require 'shared_examples_param_validation'

describe 'kafka::producer', type: :class do
  let :facts do
    {
      osfamily: 'Debian',
      operatingsystem: 'Ubuntu',
      operatingsystemrelease: '14.04',
      lsbdistcodename: 'trusty',
      architecture: 'amd64',
      service_provider: 'upstart'
    }
  end
  let :common_params do
    {
      service_config: {
        'broker-list' => 'localhost:9092',
        'topic'       => 'demo'
      },
      input: '/tmp/kafka-producer'
    }
  end

  let :params do
    common_params
  end

  it { is_expected.to contain_class('kafka::producer::install').that_comes_before('Class[kafka::producer::config]') }
  it { is_expected.to contain_class('kafka::producer::config').that_comes_before('Class[kafka::producer::service]') }
  it { is_expected.to contain_class('kafka::producer::service').that_comes_before('Class[kafka::producer]') }
  it { is_expected.to contain_class('kafka::producer') }

  context 'on Debian' do
    describe 'kafka::producer::install' do
      context 'defaults' do
        it { is_expected.to contain_class('kafka') }
      end
    end

    describe 'kafka::producer::config' do
      context 'defaults' do
        it { is_expected.to contain_file('/opt/kafka/config/producer.properties') }
      end
    end

    describe 'kafka::producer::service' do
      context 'defaults' do
        it { is_expected.to contain_file('/etc/init.d/kafka-producer') }

        it { is_expected.to contain_service('kafka-producer') }
      end
    end
  end

  context 'on CentOS' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystem: 'CentOS',
        operatingsystemrelease: '7',
        operatingsystemmajrelease: '7',
        architecture: 'amd64',
        path: '/usr/local/sbin',
        service_provider: 'systemd'
      }
    end

    describe 'kafka::producer::service' do
      context 'defaults' do
        it { is_expected.to raise_error(Puppet::Error, %r{Console Producer is not supported on systemd, because the stdin of the process cannot be redirected}) }
      end
    end
  end

  it_validates_parameter 'mirror_url'
end
