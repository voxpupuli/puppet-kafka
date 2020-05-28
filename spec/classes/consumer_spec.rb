require 'spec_helper'
require 'shared_examples_param_validation'

describe 'kafka::consumer', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
      end

      let :params do
        {
          service_config: {
            'topic'     => 'demo',
            'zookeeper' => 'localhost:2181'
          }
        }
      end

      it { is_expected.to contain_class('kafka::consumer::install').that_comes_before('Class[kafka::consumer::config]') }
      it { is_expected.to contain_class('kafka::consumer::config').that_comes_before('Class[kafka::consumer::service]') }
      it { is_expected.to contain_class('kafka::consumer::service').that_comes_before('Class[kafka::consumer]') }
      it { is_expected.to contain_class('kafka::consumer') }

      describe 'kafka::consumer::install' do
        context 'defaults' do
          it { is_expected.to contain_class('kafka') }
        end
      end

      describe 'kafka::consumer::config' do
        context 'defaults' do
          it { is_expected.to contain_file('/opt/kafka/config/consumer.properties') }
        end
      end

      describe 'kafka::consumer::service' do
        context 'defaults' do
          if os_facts[:service_provider] == 'systemd'
            it { is_expected.to contain_file('/etc/init.d/kafka-consumer').with_abent('absent') }
            it { is_expected.to contain_file('/etc/systemd/system/kafka-consumer.service').that_notifies('Exec[systemctl-daemon-relad]') }
            it { is_expected.to contain_exec('systemctl-daemon-reload').that_comes_before('Service[kafka-consumer]') }
          else
            it { is_expected.to contain_file('/etc/init.d/kafka-consumer') }
          end

          it { is_expected.to contain_service('kafka-consumer') }
        end
      end

      it_validates_parameter 'mirror_url'
    end
  end
end
