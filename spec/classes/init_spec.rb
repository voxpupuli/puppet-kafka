require 'spec_helper'

describe 'kafka', :type => :class do
  let :facts do
    {
      :osfamily               => 'Debian',
      :operatingsystem        => 'Ubuntu',
      :operatingsystemrelease => '14.04',
      :lsbdistcodename        => 'trusty',
      :architecture           => 'amd64'
    }
  end

  it { is_expected.to contain_class('kafka::params') }

  context 'on Debian' do
    describe 'kafka' do
      context 'defaults' do
        it { is_expected.to contain_group('kafka') }
        it { is_expected.to contain_user('kafka') }

        it { is_expected.to contain_file('/var/tmp/kafka') }
        it { is_expected.to contain_file('/opt/kafka-2.10-0.8.2.1') }
        it { is_expected.to contain_file('/opt/kafka') }
        it { is_expected.to contain_file('/opt/kafka/config') }
        it { is_expected.to contain_file('/var/log/kafka') }
      end
    end
  end
end
