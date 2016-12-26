require 'spec_helper'
require 'shared_examples_param_validation'

describe 'kafka::broker', type: :class do
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
      config: {
        'zookeeper.connect' => 'localhost:2181'
      }
    }
  end

  let :params do
    common_params
  end

  it { is_expected.to contain_class('kafka::broker::install').that_comes_before('Class[kafka::broker::config]') }
  it { is_expected.to contain_class('kafka::broker::config').that_comes_before('Class[kafka::broker::service]') }
  it { is_expected.to contain_class('kafka::broker::service').that_comes_before('Class[kafka::broker]') }
  it { is_expected.to contain_class('kafka::broker') }

  context 'on Debian' do
    describe 'kafka::broker::install' do
      context 'defaults' do
        it { is_expected.to contain_class('kafka') }
      end
    end

    describe 'kafka::broker::config' do
      context 'defaults' do
        it { is_expected.to contain_file('/opt/kafka/config/server.properties') }
      end
    end

    describe 'kafka::broker::service' do
      context 'service_install false' do
        let :params do
          common_params.merge(service_install: false)
        end
        it { is_expected.not_to contain_file('kafka.service') }

        it { is_expected.not_to contain_service('kafka') }
      end
      context 'defaults' do
        it { is_expected.to contain_file('kafka.service') }

        it { is_expected.to contain_service('kafka') }
      end
    end
  end

  context 'on Centos' do
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

    describe 'kafka::broker::install' do
      context 'defaults' do
        it { is_expected.to contain_class('kafka') }
      end
    end

    describe 'kafka::broker::config' do
      context 'defaults' do
        it { is_expected.to contain_file('/opt/kafka/config/server.properties') }
      end
    end

    describe 'kafka::broker::service' do
      context 'service_install false' do
        let :params do
          common_params.merge(service_install: false)
        end
        it { is_expected.not_to contain_file('kafka.service') }

        it { is_expected.not_to contain_service('kafka') }
      end

      context 'defaults' do
        it { is_expected.to contain_file('kafka.service').that_notifies('Exec[systemctl-daemon-reload]') }

        it do
          is_expected.to contain_file('/etc/init.d/kafka').with(
            ensure: 'absent'
          )
        end

        it { is_expected.to contain_exec('systemctl-daemon-reload').that_comes_before('Service[kafka]') }

        it { is_expected.to contain_service('kafka') }
      end

      context 'service_requires_zookeeper disabled' do
        let :params do
          {
            service_requires_zookeeper: false
          }
        end

        it { is_expected.not_to contain_file('kafka.service').with_content %r{^Requires=zookeeper.service$} }
      end

      context 'service_requires_zookeeper enabled' do
        let :params do
          {
            service_requires_zookeeper: true
          }
        end

        it { is_expected.to contain_file('kafka.service').with_content %r{^Requires=zookeeper.service$} }
      end
    end
  end

  it_validates_parameter 'mirror_url'
end
