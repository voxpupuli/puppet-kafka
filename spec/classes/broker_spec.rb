require 'spec_helper'
require 'shared_examples_param_validation'

describe 'kafka::broker', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
      end

      let :params do
        {
          config: {
            'zookeeper.connect' => 'localhost:2181'
          }
        }
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

      describe 'kafka::broker::service' do
        context 'manage_service false' do
          let(:params) { super().merge(manage_service: false) }

          it { is_expected.not_to contain_file('/etc/init.d/kafka') }
          it { is_expected.not_to contain_file('/etc/systemd/system/kafka.service') }
          it { is_expected.not_to contain_service('kafka') }
        end

        context 'defaults' do
          if os_facts[:service_provider] == 'systemd'
            it { is_expected.to contain_file('/etc/init.d/kafka').with_ensure('absent') }
            it { is_expected.to contain_file('/etc/systemd/system/kafka.service').that_notifies('Exec[systemctl-daemon-reload]') }
            it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^After=network\.target syslog\.target$} }
            it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^Wants=network\.target syslog\.target$} }
            it { is_expected.not_to contain_file('/etc/systemd/system/kafka.service').with_content %r{^LimitNOFILE=} }
            it { is_expected.not_to contain_file('/etc/systemd/system/kafka.service').with_content %r{^LimitCORE=} }
            it { is_expected.to contain_exec('systemctl-daemon-reload').that_comes_before('Service[kafka]') }
          else
            it { is_expected.to contain_file('/etc/init.d/kafka') }
          end

          it { is_expected.to contain_service('kafka') }
        end

        context 'limit_nofile set' do
          let(:params) { super().merge(limit_nofile: '65536') }

          if os_facts[:service_provider] == 'systemd'
            it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^LimitNOFILE=65536$} }
          else
            it { is_expected.to contain_file('/etc/init.d/kafka').with_content %r{ulimit -n 65536$} }
          end
        end

        context 'limit_core set' do
          let(:params) { super().merge(limit_core: 'infinity') }

          if os_facts[:service_provider] == 'systemd'
            it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^LimitCORE=infinity$} }
          else
            it { is_expected.to contain_file('/etc/init.d/kafka').with_content %r{ulimit -c infinity$} }
          end
        end

        context 'service_requires set', if: os_facts[:service_provider] == 'systemd' do
          let(:params) { super().merge(service_requires: ['dummy.target']) }

          it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^After=dummy\.target$} }
          it { is_expected.to contain_file('/etc/systemd/system/kafka.service').with_content %r{^Wants=dummy\.target$} }
        end
      end

      it_validates_parameter 'mirror_url'
    end
  end
end
