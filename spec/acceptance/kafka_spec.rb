require 'spec_helper_acceptance'

describe 'kafka class' do
  context 'default parameters' do
    it 'should work with no errors' do
      pp = if fact('osfamily') == 'RedHat'
             <<-EOS
               class { 'java':
                 distribution => 'jre',
               } ->

               class {'zookeeper':
                 packages             => ['zookeeper', 'zookeeper-server'],
                 service_name         => 'zookeeper-server',
                 initialize_datastore => true,
                 repo                 => 'cloudera',
               }
             EOS
           else
             <<-EOS
               class { 'java':
                 distribution => 'jre',
               } ->

               class {'zookeeper':
               }
             EOS
           end

      apply_manifest(pp, :catch_failures => true)

      pp = <<-EOS
        class { 'kafka': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end
