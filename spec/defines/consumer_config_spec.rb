require 'spec_helper'

describe 'kafka::consumer::config', type: :define do
  let :facts do
    {
      osfamily: 'Debian',
      operatingsystem: 'Ubuntu',
      operatingsystemrelease: '14.04',
      lsbdistcodename: 'trusty',
      architecture: 'amd64'
    }
  end
  let(:title) { 'consumer' }

  context 'on Debian' do
    context 'when deploy config consumer' do
      let :params do
        {
          'config'          => {},
          'config_defaults' => {},
          'service_restart' => 'true',
          'config_dir'      => '/opt/kafka/config'
        }
      end

      it { is_expected.to contain_file('/opt/kafka/config/consumer.properties') }
    end
  end
end
