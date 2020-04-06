require 'voxpupuli/acceptance/spec_helper_acceptance'

configure_beaker do |host|
  next unless fact('os.name') == 'Debian' && fact('os.release.major') == '8'
  on host, 'echo "deb http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list'
  on host, 'echo \'Acquire::Check-Valid-Until "false";\' > /etc/apt/apt.conf.d/check-valid'
  on host, 'DEBIAN_FRONTEND=noninteractive apt-get -y update'
  on host, 'DEBIAN_FRONTEND=noninteractive apt-get install -y -t jessie-backports openjdk-8-jdk'
end
