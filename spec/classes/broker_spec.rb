require 'spec_helper'
require 'shared_examples_param_validation'

describe 'kafka::broker', type: :class do
  let :facts do
    {
      osfamily: 'Debian',
      os: { family: 'Debian' },
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
        os: { family: 'RedHat' },
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

        it { is_expected.not_to contain_file('/etc/systemd/system/kafka.service') }

        it { is_expected.not_to contain_service('kafka') }
      end

      context 'defaults' do
        it { is_expected.to contain_file('/etc/systemd/system/kafka.service').that_notifies('Exec[systemctl-daemon-reload]') }
        it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^After=network\.target syslog\.target$} }
        it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^Wants=network\.target syslog\.target$} }
        it { is_expected.not_to contain_file('/etc/systemd/system/kafka.service').with_content %r{^LimitNOFILE=} }
        it { is_expected.not_to contain_file('/etc/systemd/system/kafka.service').with_content %r{^LimitCORE=} }

        it do
          is_expected.to contain_file('/etc/init.d/kafka').with(
            ensure: 'absent'
          )
        end

        it { is_expected.to contain_exec('systemctl-daemon-reload').that_comes_before('Service[kafka]') }

        it { is_expected.to contain_service('kafka') }
      end

      context 'limit_nofile set' do
        let :params do
          {
            limit_nofile: '65536'
          }
        end

        it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^LimitNOFILE=65536$} }
      end

      context 'limit_core set' do
        let :params do
          {
            limit_core: 'infinity'
          }
        end

        it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^LimitCORE=infinity$} }
      end

      context 'service_requires set' do
        let :params do
          {
            service_requires: ['dummy.target']
          }
        end

        it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^After=dummy\.target$} }
        it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^Wants=dummy\.target$} }
      end
    end
  end

  it_validates_parameter 'mirror_url'
end
