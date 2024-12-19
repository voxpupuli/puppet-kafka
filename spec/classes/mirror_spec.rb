# frozen_string_literal: true

require 'spec_helper'

describe 'kafka::mirror', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
      end

      let :params do
        {
          consumer_config: {
            'group.id'          => 'kafka-mirror',
            'zookeeper.connect' => 'localhost:2181'
          },
          producer_config: {
            'bootstrap.servers' => 'localhost:9092'
          }
        }
      end

      it { is_expected.to compile }
      it { is_expected.to contain_class('kafka::mirror::install').that_comes_before('Class[kafka::mirror::config]') }
      it { is_expected.to contain_class('kafka::mirror::config').that_comes_before('Class[kafka::mirror::service]') }
      it { is_expected.to contain_class('kafka::mirror::service').that_comes_before('Class[kafka::mirror]') }
      it { is_expected.to contain_class('kafka::mirror') }

      context 'with invalid mirror_url' do
        let(:params) { { 'mirror_url' => 'invalid' } }

        it { is_expected.not_to compile }
      end

      context 'with manage_log4j => true' do
        let(:params) { { 'manage_log4j' => true } }

        it { is_expected.to contain_class('kafka::mirror::config').with('log_file_size' => '50MB', 'log_file_count' => 7) }
      end

      describe 'kafka::mirror::install' do
        context 'defaults' do
          it { is_expected.to contain_class('kafka') }
        end
      end

      describe 'kafka::mirror::config' do
        context 'defaults' do
          it { is_expected.to contain_class('kafka::consumer::config') }
          it { is_expected.to contain_class('kafka::producer::config') }
        end
      end

      describe 'kafka::mirror::service' do
        context 'defaults' do
          it { is_expected.to contain_file('/etc/systemd/system/kafka-mirror.service').with_content %r{/opt/kafka/config/(?=.*consumer)|(?=.*producer).propertie} }
          it { is_expected.to contain_service('kafka-mirror') }
        end
      end
    end
  end
end
