# Change log

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not impact the functionality of the module.

## [v3.0.0](https://github.com/voxpupuli/puppet-kafka/tree/v3.0.0) (2017-02-13)
[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v2.3.0...v3.0.0)

**Implemented enhancements:**

- Add custom config dir [\#130](https://github.com/voxpupuli/puppet-kafka/pull/130) ([antyale](https://github.com/antyale))

## [v2.3.0](https://github.com/voxpupuli/puppet-kafka/tree/v2.3.0) (2017-02-11)
[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v2.2.0...v2.3.0)

**Closed issues:**

- broker.id should also be set in $logs\_dir/meta.properties [\#117](https://github.com/voxpupuli/puppet-kafka/issues/117)

**Merged pull requests:**

- release 2.3.0 [\#132](https://github.com/voxpupuli/puppet-kafka/pull/132) ([bastelfreak](https://github.com/bastelfreak))
- allow using any mirror\_url if it ends with tgz [\#126](https://github.com/voxpupuli/puppet-kafka/pull/126) ([petetodo](https://github.com/petetodo))
- Bump dependencies [\#125](https://github.com/voxpupuli/puppet-kafka/pull/125) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Mirror url custom port [\#121](https://github.com/voxpupuli/puppet-kafka/pull/121) ([ellamdav](https://github.com/ellamdav))

## [v2.2.0](https://github.com/voxpupuli/puppet-kafka/tree/v2.2.0) (2016-12-25)
[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v2.1.0...v2.2.0)

**Closed issues:**

- master branch not tagged [\#120](https://github.com/voxpupuli/puppet-kafka/issues/120)
- Incompatibility beetween $install\_dir and $version params [\#98](https://github.com/voxpupuli/puppet-kafka/issues/98)
- make a new release [\#72](https://github.com/voxpupuli/puppet-kafka/issues/72)

**Merged pull requests:**

- release 2.2.0 [\#124](https://github.com/voxpupuli/puppet-kafka/pull/124) ([bastelfreak](https://github.com/bastelfreak))
- Fix bounding of puppet version in metadata [\#116](https://github.com/voxpupuli/puppet-kafka/pull/116) ([ghoneycutt](https://github.com/ghoneycutt))
- Fix puppet 4 versioncmp need for string [\#115](https://github.com/voxpupuli/puppet-kafka/pull/115) ([mlambrichs](https://github.com/mlambrichs))
- Update readme with the current Kafka & Scala versions [\#112](https://github.com/voxpupuli/puppet-kafka/pull/112) ([atrepca](https://github.com/atrepca))
- Add missing badges [\#111](https://github.com/voxpupuli/puppet-kafka/pull/111) ([dhoppe](https://github.com/dhoppe))
- adding the port to the mirror URL [\#108](https://github.com/voxpupuli/puppet-kafka/pull/108) ([petetodo](https://github.com/petetodo))
- Make the systemd manifest configurable [\#105](https://github.com/voxpupuli/puppet-kafka/pull/105) ([bjoernhaeuser](https://github.com/bjoernhaeuser))

## [v2.1.0](https://github.com/voxpupuli/puppet-kafka/tree/v2.1.0) (2016-08-31)
[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v2.0.0...v2.1.0)

**Closed issues:**

- Fix regexp for URL validation \(or remove URL validation at all\) [\#92](https://github.com/voxpupuli/puppet-kafka/issues/92)
- systemv init: "$PID\_FILE does not exist, process is not running" can be wrong [\#90](https://github.com/voxpupuli/puppet-kafka/issues/90)
- kafka service should wait for zookeeper [\#81](https://github.com/voxpupuli/puppet-kafka/issues/81)
- 'archive' module conflict  [\#61](https://github.com/voxpupuli/puppet-kafka/issues/61)

**Merged pull requests:**

- prepare release for 2.1.0 [\#102](https://github.com/voxpupuli/puppet-kafka/pull/102) ([igalic](https://github.com/igalic))
- Document missing parameters [\#100](https://github.com/voxpupuli/puppet-kafka/pull/100) ([igalic](https://github.com/igalic))
- Fix incompatibility beetween $install\_dir and $version params [\#99](https://github.com/voxpupuli/puppet-kafka/pull/99) ([igalic](https://github.com/igalic))
- Add support for MirrorMaker abort.on.send.failure [\#97](https://github.com/voxpupuli/puppet-kafka/pull/97) ([SegFaultAX](https://github.com/SegFaultAX))
- fix init script to actually check status [\#96](https://github.com/voxpupuli/puppet-kafka/pull/96) ([fessyfoo](https://github.com/fessyfoo))
- Init fix [\#94](https://github.com/voxpupuli/puppet-kafka/pull/94) ([igalic](https://github.com/igalic))
- Remove URL validation [\#93](https://github.com/voxpupuli/puppet-kafka/pull/93) ([volkorny](https://github.com/volkorny))
- \[skip-ci\]Small typo fix [\#88](https://github.com/voxpupuli/puppet-kafka/pull/88) ([skade](https://github.com/skade))
- remove trailing whitespace [\#86](https://github.com/voxpupuli/puppet-kafka/pull/86) ([bastelfreak](https://github.com/bastelfreak))
- init clean-up [\#82](https://github.com/voxpupuli/puppet-kafka/pull/82) ([igalic](https://github.com/igalic))
- Sync metadata.json license to be same as LICENSE \(MIT\) [\#78](https://github.com/voxpupuli/puppet-kafka/pull/78) ([juniorsysadmin](https://github.com/juniorsysadmin))
- parameterized group-id and user-id for kafka [\#77](https://github.com/voxpupuli/puppet-kafka/pull/77) ([MaltePaulsen](https://github.com/MaltePaulsen))
- Removed dependency which is not valid with package installation [\#76](https://github.com/voxpupuli/puppet-kafka/pull/76) ([Mike-Petersen](https://github.com/Mike-Petersen))
- Allowing installation via package [\#74](https://github.com/voxpupuli/puppet-kafka/pull/74) ([Mike-Petersen](https://github.com/Mike-Petersen))
- Add support for optional default file with environment vars [\#35](https://github.com/voxpupuli/puppet-kafka/pull/35) ([knumor](https://github.com/knumor))

## [v2.0.0](https://github.com/voxpupuli/puppet-kafka/tree/v2.0.0) (2016-05-26)
[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v1.0.3...v2.0.0)

**Implemented enhancements:**

- Upgrade to Kafka 0.9.0.0 [\#30](https://github.com/voxpupuli/puppet-kafka/issues/30)

**Closed issues:**

- Fix parameter install\_dir/install\_directory [\#52](https://github.com/voxpupuli/puppet-kafka/issues/52)
- Fix parameter package\_dir [\#51](https://github.com/voxpupuli/puppet-kafka/issues/51)
- kafka::mirror is critically broken [\#39](https://github.com/voxpupuli/puppet-kafka/issues/39)
- stop trying to make fetch happen [\#31](https://github.com/voxpupuli/puppet-kafka/issues/31)
- producer init template is missing [\#13](https://github.com/voxpupuli/puppet-kafka/issues/13)
- Readme states that "config" is available within the "kafka" class [\#8](https://github.com/voxpupuli/puppet-kafka/issues/8)

**Merged pull requests:**

- Update based on voxpupuli/modulesync\_config 0.6.2 [\#71](https://github.com/voxpupuli/puppet-kafka/pull/71) ([dhoppe](https://github.com/dhoppe))
- Fix wrong syntax \(default value for ssl.enabled.protocols\) [\#70](https://github.com/voxpupuli/puppet-kafka/pull/70) ([jolivares](https://github.com/jolivares))
- Allow to set KAFKA\_OPTS [\#69](https://github.com/voxpupuli/puppet-kafka/pull/69) ([jolivares](https://github.com/jolivares))
- Update based on voxpupuli/modulesync\_config [\#68](https://github.com/voxpupuli/puppet-kafka/pull/68) ([dhoppe](https://github.com/dhoppe))
- add the jmx\_opts and log4j\_opts to the init scripts [\#67](https://github.com/voxpupuli/puppet-kafka/pull/67) ([DjxDeaf](https://github.com/DjxDeaf))
- Removing broker gc opts [\#66](https://github.com/voxpupuli/puppet-kafka/pull/66) ([bjoernhaeuser](https://github.com/bjoernhaeuser))
- add the ability to optimize all the different roles, not just the broker [\#65](https://github.com/voxpupuli/puppet-kafka/pull/65) ([DjxDeaf](https://github.com/DjxDeaf))
- fix the mirror.unit template  [\#62](https://github.com/voxpupuli/puppet-kafka/pull/62) ([DjxDeaf](https://github.com/DjxDeaf))
- Adding support to KAFKA\_HEAP\_OPTS [\#59](https://github.com/voxpupuli/puppet-kafka/pull/59) ([ortz](https://github.com/ortz))
- Support CentOS 7 [\#57](https://github.com/voxpupuli/puppet-kafka/pull/57) ([bjoernhaeuser](https://github.com/bjoernhaeuser))
- Upgrade to Kafka 0.9.0.1. This should fix \#30 [\#56](https://github.com/voxpupuli/puppet-kafka/pull/56) ([dhoppe](https://github.com/dhoppe))
- Extend Beaker tests [\#55](https://github.com/voxpupuli/puppet-kafka/pull/55) ([dhoppe](https://github.com/dhoppe))
- Fix parameter package\_dir. This closes \#51 [\#54](https://github.com/voxpupuli/puppet-kafka/pull/54) ([dhoppe](https://github.com/dhoppe))
- Fix parameter install\_dir/install\_directory. This closes \#52 [\#53](https://github.com/voxpupuli/puppet-kafka/pull/53) ([dhoppe](https://github.com/dhoppe))
- Use module voxpupuli/archive instead of wget. This should fix \#31 [\#50](https://github.com/voxpupuli/puppet-kafka/pull/50) ([dhoppe](https://github.com/dhoppe))
- Submit service\_name to cosumer::config and producer::config [\#49](https://github.com/voxpupuli/puppet-kafka/pull/49) ([dhoppe](https://github.com/dhoppe))
- \(\#8\) README: sync class parameter lists [\#48](https://github.com/voxpupuli/puppet-kafka/pull/48) ([ffrank](https://github.com/ffrank))
- Fix classes broker::consumer and broker::producer [\#46](https://github.com/voxpupuli/puppet-kafka/pull/46) ([dhoppe](https://github.com/dhoppe))
- Pin rake to avoid rubocop/rake 11 incompatibility [\#45](https://github.com/voxpupuli/puppet-kafka/pull/45) ([roidelapluie](https://github.com/roidelapluie))
- Add missing dependency [\#44](https://github.com/voxpupuli/puppet-kafka/pull/44) ([dhoppe](https://github.com/dhoppe))
- Fix indentation of class parameters [\#43](https://github.com/voxpupuli/puppet-kafka/pull/43) ([dhoppe](https://github.com/dhoppe))
- Fix several issues regarding mirror, producer and RSpec tests [\#41](https://github.com/voxpupuli/puppet-kafka/pull/41) ([dhoppe](https://github.com/dhoppe))
- Fix empty PID file creation on failed daemon start [\#40](https://github.com/voxpupuli/puppet-kafka/pull/40) ([dhoppe](https://github.com/dhoppe))
- Mirror num\_streams num\_producers max\_heap params [\#37](https://github.com/voxpupuli/puppet-kafka/pull/37) ([travees](https://github.com/travees))
- Widen output to find the kafka string when getting PID [\#34](https://github.com/voxpupuli/puppet-kafka/pull/34) ([knumor](https://github.com/knumor))
- Support CentOS 7 [\#23](https://github.com/voxpupuli/puppet-kafka/pull/23) ([bjoernhaeuser](https://github.com/bjoernhaeuser))
- attempt to fix \#3 \(allow to configure service manually\) [\#12](https://github.com/voxpupuli/puppet-kafka/pull/12) ([feniix](https://github.com/feniix))

## [v1.0.3](https://github.com/voxpupuli/puppet-kafka/tree/v1.0.3) (2016-01-22)
[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v1.0.2...v1.0.3)

**Closed issues:**

- Puppet forge module outdated: ArgumentError: Could not find declared class java  [\#27](https://github.com/voxpupuli/puppet-kafka/issues/27)
- Puppetforge module outdated: The init script leaves pidfile if there's an error when starting [\#26](https://github.com/voxpupuli/puppet-kafka/issues/26)
- Ubuntu 12.04/14.04 LTS Compatibility Broken [\#24](https://github.com/voxpupuli/puppet-kafka/issues/24)
- kafka starting as a root user [\#17](https://github.com/voxpupuli/puppet-kafka/issues/17)
- Both "version" and "scala\_version" are ignored within "kafka::broker" [\#9](https://github.com/voxpupuli/puppet-kafka/issues/9)
- init script is incompatible with chkconfig [\#5](https://github.com/voxpupuli/puppet-kafka/issues/5)

**Merged pull requests:**

- Update module to version 1.0.3 [\#29](https://github.com/voxpupuli/puppet-kafka/pull/29) ([dhoppe](https://github.com/dhoppe))

## [v1.0.2](https://github.com/voxpupuli/puppet-kafka/tree/v1.0.2) (2015-12-11)
[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v1.0.1...v1.0.2)

**Closed issues:**

- Missing dependency on puppetlabs-java [\#19](https://github.com/voxpupuli/puppet-kafka/issues/19)

**Merged pull requests:**

- Update module to version 1.0.2 [\#28](https://github.com/voxpupuli/puppet-kafka/pull/28) ([dhoppe](https://github.com/dhoppe))
- README changes with an example of use. [\#20](https://github.com/voxpupuli/puppet-kafka/pull/20) ([GabrielNicolasAvellaneda](https://github.com/GabrielNicolasAvellaneda))
- Added missing dependency on puppetlabs-java [\#18](https://github.com/voxpupuli/puppet-kafka/pull/18) ([GabrielNicolasAvellaneda](https://github.com/GabrielNicolasAvellaneda))
- Update init.erb [\#16](https://github.com/voxpupuli/puppet-kafka/pull/16) ([VuokkoVuorinnen](https://github.com/VuokkoVuorinnen))
- Make wget installation optional [\#15](https://github.com/voxpupuli/puppet-kafka/pull/15) ([danieldreier](https://github.com/danieldreier))
- Make beaker run on centos [\#7](https://github.com/voxpupuli/puppet-kafka/pull/7) ([bjoernhaeuser](https://github.com/bjoernhaeuser))

## [v1.0.1](https://github.com/voxpupuli/puppet-kafka/tree/v1.0.1) (2015-03-24)
[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v1.0.0...v1.0.1)

**Closed issues:**

- ability to set the service to disabled [\#3](https://github.com/voxpupuli/puppet-kafka/issues/3)

**Merged pull requests:**

- Moar file descriptors! \(quoting https://github.com/stack72\) [\#1](https://github.com/voxpupuli/puppet-kafka/pull/1) ([pablete](https://github.com/pablete))

## [v1.0.0](https://github.com/voxpupuli/puppet-kafka/tree/v1.0.0) (2014-10-10)
[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v0.2.1...v1.0.0)

## [v0.2.1](https://github.com/voxpupuli/puppet-kafka/tree/v0.2.1) (2014-06-02)
[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v0.2.0...v0.2.1)

## [v0.2.0](https://github.com/voxpupuli/puppet-kafka/tree/v0.2.0) (2014-06-02)
[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v0.1.0...v0.2.0)

## [v0.1.0](https://github.com/voxpupuli/puppet-kafka/tree/v0.1.0) (2014-05-28)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
