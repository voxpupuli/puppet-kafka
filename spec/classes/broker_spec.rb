require 'spec_helper'

describe 'kafka::broker', type: :class do
  let :facts do
    {
      osfamily: 'Debian',
      operatingsystem: 'Ubuntu',
      operatingsystemrelease: '14.04',
      lsbdistcodename: 'trusty',
      architecture: 'amd64',
      service_provider: 'upstart',
    }
  end
  let :params do
    {
      config: {
        'zookeeper.connect' => 'localhost:2181',
      },
    }
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
          {
            config: {
              'zookeeper.connect' => 'localhost:2181',
            },
            service_install: false,
          }
        end
        it { is_expected.not_to contain_file('/etc/init.d/kafka') }

        it { is_expected.not_to contain_service('kafka') }
      end
      context 'defaults' do
        it { is_expected.to contain_file('/etc/init.d/kafka') }

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
        service_provider: 'systemd',
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
          {
            config: {
              'zookeeper.connect' => 'localhost:2181',
            },
            service_install: false,
          }
        end
        it { is_expected.not_to contain_file('/usr/lib/systemd/system/kafka.service') }

        it { is_expected.not_to contain_service('kafka') }
      end
      context 'defaults' do
        it { is_expected.to contain_file('/usr/lib/systemd/system/kafka.service').that_notifies('Exec[systemctl-daemon-reload]') }

        it {
          is_expected.to contain_file('/etc/init.d/kafka').with(
            ensure: 'absent',
          )
        }

        it { is_expected.to contain_exec('systemctl-daemon-reload').that_comes_before('Service[kafka]') }

        it { is_expected.to contain_service('kafka') }
      end
    end
  end
end
