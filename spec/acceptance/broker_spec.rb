require 'spec_helper_acceptance'

describe 'kafka::broker' do
  it 'works with no errors' do
    pp = <<-EOS
      class { 'zookeeper': } ->
      class { 'kafka::broker':
        config => {
          'zookeeper.connect' => 'localhost:2181',
        },
      } ->
      kafka::broker::topic { 'demo':
        ensure    => present,
        zookeeper => 'localhost:2181',
      }
    EOS

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe 'kafka::broker::install' do
    context 'with default parameters' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'zookeeper': } ->
          class { 'kafka::broker':
            config => {
              'zookeeper.connect' => 'localhost:2181',
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

  describe 'kafka::broker::config' do
    context 'with default parameters' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'zookeeper': } ->
          class { 'kafka::broker':
            config => {
              'zookeeper.connect' => 'localhost:2181',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
      end

      describe file('/opt/kafka/config/server.properties') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
        it { is_expected.to contain 'ssl.enabled.protocols=TLSv1.2,TLSv1.1,TLSv1' }
      end
    end

    context 'with custom config dir' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'zookeeper': } ->
          class { 'kafka::broker':
            config => {
              'zookeeper.connect' => 'localhost:2181',
            },
            config_dir => '/opt/kafka/custom_config'
          }
        EOS

        apply_manifest(pp, catch_failures: true)
      end

      describe file('/opt/kafka/custom_config/server.properties') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
        it { is_expected.to contain 'ssl.enabled.protocols=TLSv1.2,TLSv1.1,TLSv1' }
      end
    end

    context 'with specific version' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'zookeeper': } ->
          class { 'kafka::broker':
            version => '0.8.2.2',
            config  => {
              'broker.id'         => '1',
              'zookeeper.connect' => 'localhost:2181',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
      end

      describe file('/opt/kafka/config/server.properties') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'kafka' }
        it { is_expected.to be_grouped_into 'kafka' }
      end
    end
  end

  describe 'kafka::broker::service' do
    context 'with default parameters' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'zookeeper': } ->
          class { 'kafka::broker':
            config => {
              'zookeeper.connect' => 'localhost:2181',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
      end

      describe file('/etc/init.d/kafka'), if: (fact('operatingsystemmajrelease') =~ %r{(5|6)} && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
      end

      describe file('/usr/lib/systemd/system/kafka.service'), if: (fact('operatingsystemmajrelease') == '7' && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to contain 'Requires=zookeeper.service' }
      end

      describe service('kafka') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end
    end
  end

  describe 'kafka::broker::service' do
    context 'with require zookeeper disabled' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'zookeeper': } ->
          class { 'kafka::broker':
            service_requires_zookeeper => false,
            config                      => {
              'zookeeper.connect' => 'localhost:2181',
            },
          }
        EOS

        apply_manifest(pp, catch_failures: true)
      end

      describe file('/etc/init.d/kafka'), if: (fact('operatingsystemmajrelease') =~ %r{(5|6)} && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
      end

      describe file('/usr/lib/systemd/system/kafka.service'), if: (fact('operatingsystemmajrelease') == '7' && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.not_to contain 'Requires=zookeeper.service' }
      end

      describe service('kafka') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end
    end
  end

  describe 'kafka::broker::service' do
    context 'with log4j/jmx parameters' do
      it 'works with no errors' do
        pp = <<-EOS
          class { 'zookeeper': } ->
          class { 'kafka::broker':
            config => {
              'zookeeper.connect' => 'localhost:2181',
            },
            heap_opts  => '-Xmx512M -Xmx512M',
            log4j_opts => '-Dlog4j.configuration=file:/tmp/log4j.properties',
            jmx_opts   => '-Dcom.sun.management.jmxremote',
            opts       => '-Djava.security.policy=/some/path/my.policy'
          }
        EOS

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end

      describe file('/etc/init.d/kafka'), if: (fact('operatingsystemmajrelease') =~ %r{(5|6)} && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to contain 'export KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9999"' }
        it { is_expected.to contain 'export KAFKA_HEAP_OPTS="-Xmx512M -Xmx512M"' }
        it { is_expected.to contain 'export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:$base_dir/../config/log4j.properties"' }
      end

      describe file('/usr/lib/systemd/system/kafka.service'), if: (fact('operatingsystemmajrelease') == '7' && fact('osfamily') == 'RedHat') do
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to contain "Environment='KAFKA_JMX_OPTS=-Dcom.sun.management.jmxremote'" }
        it { is_expected.to contain "Environment='KAFKA_HEAP_OPTS=-Xmx512M -Xmx512M'" }
        it { is_expected.to contain "Environment='KAFKA_LOG4J_OPTS=-Dlog4j.configuration=file:/tmp/log4j.properties'" }
        it { is_expected.to contain "Environment='KAFKA_OPTS=-Djava.security.policy=/some/path/my.policy'" }
      end

      describe service('kafka') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end
    end
  end
end
