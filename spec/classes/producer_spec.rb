# frozen_string_literal: true

require 'spec_helper'

describe 'kafka::producer', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
      end

      let :params do
        {
          service_config: {
            'broker-list' => 'localhost:9092',
            'topic'       => 'demo'
          },
          input: '/tmp/kafka-producer'
        }
      end

      it { is_expected.to compile.and_raise_error(%r{Console Producer is not supported on systemd, because the stdin of the process cannot be redirected}) }
    end
  end
end
