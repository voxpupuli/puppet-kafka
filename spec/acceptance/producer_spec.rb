require 'spec_helper_acceptance'

describe 'kafka::producer', if: !(fact('operatingsystemmajrelease') == '7' && fact('osfamily') == 'RedHat') do
  it 'works with no errors' do
    pp = <<-EOS
      exec { 'create fifo':
        command => '/bin/mkfifo /tmp/kafka-producer',
        user    => 'kafka',
        creates => '/tmp/kafka-producer',
      } ->
      class { 'zookeeper': } ->
      class { 'kafka::producer':
        service_config => {
          'broker-list' => 'localhost:9092',
          topic         => 'demo',
        },
        input => '3<>/tmp/kafka-producer 0>&3',
      }
    EOS

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe 'kafka::producer::install' do
    context 'with default parameters' do
      it 'works with no errors' do
        pp = <<-EOS
          exec { 'create fifo':
            command => '/bin/mkfifo /tmp/kafka-producer',
            user    => 'kafka',
            creates => '/tmp/kafka-producer',
          } ->
          class { 'zookeeper': } ->
          class { 'kafka::producer':
            service_config => {
              'broker-list' => 'localhost:9092',
              topic         => 'demo',
            },
            input          => '3<>/tmp/kafka-producer 0>&3',
          }
        EOS

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end

      describe group('kafka') do
        it { is_expected.to exist }
      end

      describe user('kafka') do
        it { is_expected.to exist }
        it { is_expected.to belong_to_group 'kafka' }
        it { is_expected.to have_login_shell '/bin/bash' }
      end

      describe file('/var/tmp/kafka') do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end

      describe file('/opt/kafka-2.11-0.9.0.1') do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end

      describe file('/opt/kafka') do
        it { is_expected.to be_linked_to('/opt/kafka-2.11-0.9.0.1') }
      end

      describe file('/opt/kafka/config') do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end

      describe file('/var/log/kafka') do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end
    end
  end

  describe 'kafka::producer::config' do
    context 'with default parameters' do
      it 'works with no errors' do
        pp = <<-EOS
          exec { 'create fifo':
            command => '/bin/mkfifo /tmp/kafka-producer',
            user    => 'kafka',
            creates => '/tmp/kafka-producer',
          } ->
          class { 'zookeeper': } ->
          class { 'kafka::producer':
            service_config => {
              'broker-list' => 'localhost:9092',
              topic         => 'demo',
            },
            input          => '3<>/tmp/kafka-producer 0>&3',
          }
        EOS

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end

      describe file('/opt/kafka/config/producer.properties') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end
    end
  end

  describe 'kafka::producer::service' do
    context 'with default parameters' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'zookeeper': } ->
          class { 'kafka::producer':
            service_config => {
              'broker-list' => 'localhost:9092',
              topic         => 'demo',
            },
            input          => '3<>/tmp/kafka-producer 0>&3',
          }
        EOS

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end

      describe file('/etc/init.d/kafka-producer'), if: (fact('operatingsystemmajrelease') =~ %r{(5|6)} && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to contain 'export KAFKA_JMX_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false' }
        it { is_expected.to contain 'export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:$base_dir/../config/log4j.properties"' }
      end

      describe file('/usr/lib/systemd/system/kafka-producer.service'), if: (fact('operatingsystemmajrelease') == '7' && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to contain 'export KAFKA_JMX_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false' }
        it { is_expected.to contain 'export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:$base_dir/../config/log4j.properties"' }
      end

      describe service('kafka-producer') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end
    end
  end
end
