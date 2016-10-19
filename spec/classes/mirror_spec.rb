require 'spec_helper'

describe 'kafka::mirror', type: :class do
  let :facts do
    {
      osfamily: 'Debian',
      operatingsystem: 'Ubuntu',
      operatingsystemrelease: '14.04',
      lsbdistcodename: 'trusty',
      architecture: 'amd64',
      service_provider: 'upstart'
    }
  end

  let :common_params do
    {
      consumer_config: {
        'group.id'          => 'kafka-mirror',
        'zookeeper.connect' => 'localhost:2181'
      },
      producer_config: {
        'bootstrap.servers' => 'localhost:9092'
      }
    }
  end

  let :params do
    common_params
  end

  it { is_expected.to contain_class('kafka::mirror::install').that_comes_before('Class[kafka::mirror::config]') }
  it { is_expected.to contain_class('kafka::mirror::config').that_comes_before('Class[kafka::mirror::service]') }
  it { is_expected.to contain_class('kafka::mirror::service').that_comes_before('Class[kafka::mirror]') }
  it { is_expected.to contain_class('kafka::mirror') }

  context 'on Debian' do
    describe 'kafka::mirror::install' do
      context 'defaults' do
        it { is_expected.to contain_class('kafka') }
      end
    end

    describe 'kafka::mirror::config' do
      context 'defaults' do
        it { is_expected.to contain_class('kafka::producer::config') }
      end
    end

    describe 'kafka::mirror::service' do
      context 'defaults' do
        it { is_expected.to contain_file('kafka-mirror.service') }

        it { is_expected.to contain_service('kafka-mirror') }
      end
    end
  end

  context 'on CentOS' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystem: 'CentOS',
        operatingsystemrelease: '7',
        operatingsystemmajrelease: '7',
        architecture: 'amd64',
        path: '/usr/local/sbin',
        service_provider: 'systemd'
      }
    end

    describe 'kafka::mirror::install' do
      context 'defaults' do
        it { is_expected.to contain_class('kafka') }
      end
    end

    describe 'kafka::mirror::config' do
      context 'defaults' do
        it { is_expected.to contain_class('kafka::producer::config') }
      end
    end

    describe 'kafka::mirror::service' do
      context 'defaults' do
        it { is_expected.to contain_file('kafka-mirror.service').that_notifies('Exec[systemctl-daemon-reload]') }

        it do
          is_expected.to contain_file('/etc/init.d/kafka-mirror').with(
            ensure: 'absent'
          )
        end

        it { is_expected.to contain_exec('systemctl-daemon-reload').that_comes_before('Service[kafka-mirror]') }

        it { is_expected.to contain_service('kafka-mirror') }
      end

      context 'service_requires_zookeeper disabled' do
        let :params do
          common_params.merge(service_requires_zookeeper: false)
        end

        it { should_not contain_file('kafka-mirror.service').with_content %r{^Requires=zookeeper.service$} }
      end

      context 'service_requires_zookeeper enabled' do
        let :params do
          common_params.merge(service_requires_zookeeper: true)
        end

        it { should contain_file('kafka-mirror.service').with_content %r{^Requires=zookeeper.service$} }
      end
    end
  end

  context 'with mirror_url' do

    domain_names = {
      'foobar.com'  => true,
      'foo.bar.com' => true,
      '999.bar.com' => true,
      'foo-bar.com' => true,
      'no-tld'      => false,
      'foo.longtld' => false,
    }

    prefixes = {
      'http://'   => true,
      'https://'  => true,
      'random://' => false,
    }

    paths = {
      ''                      => true,
      '/'                     => true,
      '/package'              => true,
      '/package/'             => true,
      '/another/package'      => true,
      '/yet/another/package/' => true,
    }

    ports = {
      ''        => true,
      ':9'      => false,
      ':10'     => true,
      ':99999'  => true,
      ':100000' => false,
    }

    prefixes.each do |prefix, valid_prefix|
      context "with prefix <#{prefix}>" do

        domain_names.each do |domain_name, valid_domain|
          context "with domain name <#{domain_name}>" do

            paths.each do |path, valid_path|
              context "with path <#{path}>" do

                ports.each do |port, valid_port|
                  context "with port <#{port}>" do

                    mirror_url = "#{prefix}#{domain_name}#{port}#{path}"
                    context "URL => <#{mirror_url}>" do
                      let :params do
                        common_params.merge(mirror_url: mirror_url)
                      end

                      if valid_domain && valid_prefix && valid_path && valid_port
                        it { is_expected.to compile }
                      else
                        it { expect { is_expected.to compile }.to raise_error(/#{mirror_url} is not a valid url/) }
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
