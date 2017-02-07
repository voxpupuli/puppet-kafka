require 'spec_helper_acceptance'

describe 'kafka::mirror' do
  it 'works with no errors' do
    pp = <<-EOS
      class { 'zookeeper': } ->
      class { 'kafka::mirror':
        consumer_config => {
          'group.id'          => 'kafka-mirror',
          'zookeeper.connect' => 'localhost:2181',
        },
        producer_config => {
          'bootstrap.servers' => 'localhost:9092',
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
          class { 'zookeeper': } ->
          class { 'kafka::mirror':
            consumer_config => {
              'group.id'          => 'kafka-mirror',
              'zookeeper.connect' => 'localhost:2181',
            },
            producer_config => {
              'bootstrap.servers' => 'localhost:9092',
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

  describe 'kafka::mirror::config' do
    context 'with default parameters' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'zookeeper': } ->
          class { 'kafka::mirror':
            consumer_config => {
              'group.id'          => 'kafka-mirror',
              'zookeeper.connect' => 'localhost:2181',
            },
            producer_config => {
              'bootstrap.servers' => 'localhost:9092',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
      end

      describe file('/opt/kafka/config/consumer-1.properties') do
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
          class { 'zookeeper': } ->
          class { 'kafka::mirror':
            consumer_config => {
              'group.id'          => 'kafka-mirror',
              'zookeeper.connect' => 'localhost:2181',
            },
            producer_config => {
              'bootstrap.servers' => 'localhost:9092',
            },
            config_dir => '/opt/kafka/custom_config'
          }
        EOS

        apply_manifest(pp, catch_failures: true)
      end

      describe file('/opt/kafka/custom_config/consumer-1.properties') do
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
          class { 'zookeeper': } ->
          class { 'kafka::mirror':
            version         => '0.9.0.0',
            consumer_config => {
              'group.id'          => 'kafka-mirror',
              'zookeeper.connect' => 'localhost:2181',
            },
            producer_config => {
              'bootstrap.servers' => 'localhost:9092',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
      end

      describe file('/opt/kafka/config/consumer-1.properties') do
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
          class { 'zookeeper': } ->
          class { 'kafka::mirror':
            consumer_config => {
              'group.id'          => 'kafka-mirror',
              'zookeeper.connect' => 'localhost:2181',
            },
            producer_config => {
              'bootstrap.servers' => 'localhost:9092',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
      end

      describe file('/etc/init.d/kafka-mirror'), if: (fact('operatingsystemmajrelease') =~ %r{(5|6)} && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to contain 'export KAFKA_JMX_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false' }
        it { is_expected.to contain 'export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:$base_dir/../config/log4j.properties"' }
      end

      describe file('/usr/lib/systemd/system/kafka-mirror.service'), if: (fact('operatingsystemmajrelease') == '7' && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to contain 'export KAFKA_JMX_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false' }
        it { is_expected.to contain 'export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:$base_dir/../config/log4j.properties"' }
        it { is_expected.to contain 'Requires=zookeeper.service' }
      end

      describe service('kafka-mirror') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end
    end

    context 'with require zookeeper disabled' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'zookeeper': } ->
          class { 'kafka::mirror':
            service_requires_zookeeper => false,
            consumer_config => {
              'group.id'          => 'kafka-mirror',
              'zookeeper.connect' => 'localhost:2181',
            },
            producer_config => {
              'bootstrap.servers' => 'localhost:9092',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
      end

      describe file('/etc/init.d/kafka-mirror'), if: (fact('operatingsystemmajrelease') =~ %r{(5|6)} && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to contain 'export KAFKA_JMX_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false' }
        it { is_expected.to contain 'export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:$base_dir/../config/log4j.properties"' }
      end

      describe file('/usr/lib/systemd/system/kafka-mirror.service'), if: (fact('operatingsystemmajrelease') == '7' && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.not_to contain 'Requires=zookeeper.service' }
      end

      describe service('kafka-mirror') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end
    end
  end
end
