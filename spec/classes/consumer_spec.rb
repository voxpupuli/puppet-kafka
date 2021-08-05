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

      context 'with manage_log4j => true' do
        let(:params) { { 'manage_log4j' => true } }

        it { is_expected.to contain_class('kafka::consumer::config').with('log_file_size' => '50MB', 'log_file_count' => 7) }
      end

      describe 'kafka::consumer::install' do
        context 'defaults' do
          it { is_expected.to contain_class('kafka') }
        end
      end

      describe 'kafka::consumer::config' do
        context 'defaults' do
          it { is_expected.to contain_file('/opt/kafka/config/consumer.properties') }
        end
        context 'with  manage_log4j => true' do
          let(:params) { { 'manage_log4j' => true } }

          it { is_expected.to contain_file('/opt/kafka/config/log4j.properties').with_content(%r{^log4j.appender.kafkaAppender.MaxFileSize=50MB$}) }
          it { is_expected.to contain_file('/opt/kafka/config/log4j.properties').with_content(%r{^log4j.appender.kafkaAppender.MaxBackupIndex=7$}) }
        end
      end

      describe 'kafka::consumer::service' do
        context 'defaults' do
          if os_facts[:service_provider] == 'systemd'
            it { is_expected.to contain_file('/etc/init.d/kafka-consumer').with_abent('absent') }
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
