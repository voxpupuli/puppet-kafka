require 'spec_helper'

describe 'kafka::broker', :type => :class do
  let :facts do
    {
      :osfamily               => 'Debian',
      :operatingsystem        => 'Ubuntu',
      :operatingsystemrelease => '14.04',
      :lsbdistcodename        => 'trusty',
      :architecture           => 'amd64'
    }
  end

  it { is_expected.to contain_class('kafka::broker::install').that_comes_before('Class[kafka::broker::config]') }
  it { is_expected.to contain_class('kafka::broker::config').that_comes_before('Class[kafka::broker::service]') }
  it { is_expected.to contain_class('kafka::broker::service').that_comes_before('Class[kafka::broker]') }
  it { is_expected.to contain_class('kafka::broker') }

  context 'on Debian' do
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
      context 'defaults' do
        it { is_expected.to contain_file('/etc/init.d/kafka') }

        it { is_expected.to contain_service('kafka') }
      end
    end
  end
end
