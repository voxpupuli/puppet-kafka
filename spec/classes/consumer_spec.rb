require 'spec_helper'

describe 'kafka::consumer', :type => :class do
  let :facts do
    {
      :osfamily               => 'Debian',
      :operatingsystem        => 'Ubuntu',
      :operatingsystemrelease => '14.04',
      :lsbdistcodename        => 'trusty',
      :architecture           => 'amd64'
    }
  end

  it { is_expected.to contain_class('kafka::consumer::install').that_comes_before('Class[kafka::consumer::service]') }
  it { is_expected.to contain_class('kafka::consumer::service').that_comes_before('Class[kafka::consumer]') }
  it { is_expected.to contain_class('kafka::consumer') }

  context 'on Debian' do
    describe 'kafka::consumer::install' do
      context 'defaults' do
        it { is_expected.to contain_class('kafka') }
      end
    end

    describe 'kafka::consumer::service' do
      context 'defaults' do
        it { is_expected.to contain_file('/etc/init.d/kafka-consumer') }

        it { is_expected.to contain_service('kafka-consumer') }
      end
    end
  end
end
