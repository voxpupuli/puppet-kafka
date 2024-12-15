# frozen_string_literal: true

require 'spec_helper'

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

      it { is_expected.to compile }
      it { is_expected.to contain_class('kafka::consumer::install').that_comes_before('Class[kafka::consumer::config]') }
      it { is_expected.to contain_class('kafka::consumer::config').that_comes_before('Class[kafka::consumer::service]') }
      it { is_expected.to contain_class('kafka::consumer::service').that_comes_before('Class[kafka::consumer]') }
      it { is_expected.to contain_class('kafka::consumer') }

      context 'with invalid mirror_url' do
        let(:params) { { 'mirror_url' => 'invalid' } }

        it { is_expected.not_to compile }
      end

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

        context 'with manage_log4j => true' do
          let(:params) { { 'manage_log4j' => true } }

          it { is_expected.to contain_file('/opt/kafka/config/log4j.properties').with_content(%r{^log4j.appender.kafkaAppender.MaxFileSize=50MB$}) }
          it { is_expected.to contain_file('/opt/kafka/config/log4j.properties').with_content(%r{^log4j.appender.kafkaAppender.MaxBackupIndex=7$}) }
        end
      end

      describe 'kafka::consumer::service' do
        context 'defaults' do
          it { is_expected.to contain_file('/etc/systemd/system/kafka-consumer.service') }
          it { is_expected.to contain_service('kafka-consumer') }
        end
      end
    end
  end
end
