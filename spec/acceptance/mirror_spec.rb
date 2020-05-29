require 'spec_helper_acceptance'

if fact('operatingsystemmajrelease') == '6' && fact('osfamily') == 'RedHat'
  user_shell = '/bin/bash'
else
  case fact('osfamily')
  when 'RedHat', 'Suse'
    user_shell = '/sbin/nologin'
  when 'Debian'
    user_shell = '/usr/sbin/nologin'
  end
end

describe 'kafka::mirror' do
  it 'works with no errors' do
    pp = <<-EOS
      class { 'kafka::mirror':
        consumer_config => {
          'group.id'          => 'kafka-mirror',
          'bootstrap.servers' => 'localhost:9092',
        },
        producer_config => {
          'bootstrap.servers' => 'localhost:9092',
        },
        service_config => {
          'whitelist' => '.*',
        },
      }
    EOS

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe 'kafka::mirror::install' do
    context 'with default parameters' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'kafka::mirror':
            consumer_config => {
              'group.id'          => 'kafka-mirror',
              'bootstrap.servers' => 'localhost:9092',
            },
            producer_config => {
              'bootstrap.servers' => 'localhost:9092',
            },
            service_config => {
              'whitelist' => '.*',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
      end

      describe group('kafka') do
        it { is_expected.to exist }
      end

      describe user('kafka') do
        it { is_expected.to exist }
        it { is_expected.to belong_to_group 'kafka' }
        it { is_expected.to have_login_shell user_shell }
      end

      describe file('/var/tmp/kafka') do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end

      describe file('/opt/kafka-2.12-2.4.1') do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end

      describe file('/opt/kafka') do
        it { is_expected.to be_linked_to('/opt/kafka-2.12-2.4.1') }
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

  describe 'kafka::mirror::config' do
    context 'with default parameters' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'kafka::mirror':
            consumer_config => {
              'group.id'          => 'kafka-mirror',
              'bootstrap.servers' => 'localhost:9092',
            },
            producer_config => {
              'bootstrap.servers' => 'localhost:9092',
            },
            service_config => {
              'whitelist' => '.*',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end

      describe file('/opt/kafka/config/consumer.properties') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end

      describe file('/opt/kafka/config/producer.properties') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end
    end

    context 'with custom config_dir' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'kafka::mirror':
            consumer_config => {
              'group.id'          => 'kafka-mirror',
              'bootstrap.servers' => 'localhost:9092',
            },
            producer_config => {
              'bootstrap.servers' => 'localhost:9092',
            },
            service_config => {
              'whitelist' => '.*',
            },
            config_dir => '/opt/kafka/custom_config',
          }
        EOS

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end

      describe file('/opt/kafka/custom_config/consumer.properties') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end

      describe file('/opt/kafka/custom_config/producer.properties') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end
    end

    context 'with specific version' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'kafka::mirror':
            kafka_version   => '2.4.0',
            consumer_config => {
              'group.id'          => 'kafka-mirror',
              'bootstrap.servers' => 'localhost:9092',
            },
            producer_config => {
              'bootstrap.servers' => 'localhost:9092',
            },
            service_config => {
              'whitelist' => '.*',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end

      describe file('/opt/kafka/config/consumer.properties') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end

      describe file('/opt/kafka/config/producer.properties') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end
    end
  end

  describe 'kafka::mirror::service' do
    context 'with default parameters' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'kafka::mirror':
            consumer_config => {
              'group.id'          => 'kafka-mirror',
              'bootstrap.servers' => 'localhost:9092',
            },
            producer_config => {
              'bootstrap.servers' => 'localhost:9092',
            },
            service_config => {
              'whitelist' => '.*',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end

      describe file('/etc/init.d/kafka-mirror'), if: (fact('operatingsystemmajrelease') == '6' && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to contain 'export KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9991"' }
        it { is_expected.to contain 'export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:/opt/kafka/config/log4j.properties"' }
      end

      describe file('/etc/init.d/kafka-mirror'), if: (fact('service_provider') == 'upstart' && fact('osfamily') == 'Debian') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to contain %r{^# Provides:\s+kafka-mirror$} }
        it { is_expected.to contain 'export KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9991"' }
        it { is_expected.to contain 'export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:/opt/kafka/config/log4j.properties"' }
      end

      describe file('/etc/systemd/system/kafka-mirror.service'), if: (fact('operatingsystemmajrelease') == '7' && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to contain 'Environment=\'KAFKA_JMX_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9991\'' }
        it { is_expected.to contain 'Environment=\'KAFKA_LOG4J_OPTS=-Dlog4j.configuration=file:/opt/kafka/config/log4j.properties\'' }
      end

      describe service('kafka-mirror') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end
    end
  end
end
