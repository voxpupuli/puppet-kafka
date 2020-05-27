require 'spec_helper'
require 'shared_examples_param_validation'

describe 'kafka::broker', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
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

      describe 'kafka::broker::service', if: os_facts[:service_provider] == 'systemd' do
        context 'manage_service false' do
          let :params do
            common_params.merge(manage_service: false)
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

      describe 'kafka::broker::service', unless: os_facts[:service_provider] == 'systemd' do
        context 'manage_service false' do
          let :params do
            common_params.merge(manage_service: false)
          end

          it { is_expected.not_to contain_file('/etc/init.d/kafka') }
          it { is_expected.not_to contain_service('kafka') }
        end

        context 'defaults' do
          it { is_expected.to contain_file('/etc/init.d/kafka') }
          it { is_expected.to contain_service('kafka') }
        end

        context 'limit_nofile set' do
          let :params do
            {
              limit_nofile: '65536'
            }
          end

          it { is_expected.to contain_file('/etc/init.d/kafka').with_content %r{ulimit -n 65536$} }
        end

        context 'limit_core set' do
          let :params do
            {
              limit_core: 'infinity'
            }
          end

          it { is_expected.to contain_file('/etc/init.d/kafka').with_content %r{ulimit -c infinity$} }
        end
      end

      it_validates_parameter 'mirror_url'
    end
  end
end
