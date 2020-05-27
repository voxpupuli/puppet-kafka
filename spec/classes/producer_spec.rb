require 'spec_helper'
require 'shared_examples_param_validation'

describe 'kafka::producer', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
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

      describe 'kafka::producer::service', if: os_facts[:service_provider] == 'systemd' do
        context 'defaults' do
          it { is_expected.to raise_error(Puppet::Error, %r{Console Producer is not supported on systemd, because the stdin of the process cannot be redirected}) }
        end
      end

      describe 'kafka::producer::service', unless: os_facts[:service_provider] == 'systemd' do
        context 'defaults' do
          it { is_expected.to contain_file('/etc/init.d/kafka-producer') }
          it { is_expected.to contain_service('kafka-producer') }
        end
      end

      it_validates_parameter 'mirror_url'
    end
  end
end
