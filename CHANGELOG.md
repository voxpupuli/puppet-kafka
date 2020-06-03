# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v7.0.0](https://github.com/voxpupuli/puppet-kafka/tree/v7.0.0) (2020-06-03)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v6.0.0...v7.0.0)

**Breaking changes:**

- Add parameter user\_shell [\#315](https://github.com/voxpupuli/puppet-kafka/pull/315) ([dhoppe](https://github.com/dhoppe))
- Rename parameters [\#303](https://github.com/voxpupuli/puppet-kafka/pull/303) ([dhoppe](https://github.com/dhoppe))
- Make owner of files/directories configurable [\#299](https://github.com/voxpupuli/puppet-kafka/pull/299) ([dhoppe](https://github.com/dhoppe))

**Implemented enhancements:**

- Add support for Hiera [\#316](https://github.com/voxpupuli/puppet-kafka/pull/316) ([dhoppe](https://github.com/dhoppe))
- Add support for SLES 11/12/15 [\#314](https://github.com/voxpupuli/puppet-kafka/pull/314) ([dhoppe](https://github.com/dhoppe))
- Add support for Puppet Strings [\#304](https://github.com/voxpupuli/puppet-kafka/pull/304) ([dhoppe](https://github.com/dhoppe))
- Add function assert\_private\(\) [\#301](https://github.com/voxpupuli/puppet-kafka/pull/301) ([dhoppe](https://github.com/dhoppe))
- Add support for Debian 10, Ubuntu 18.04 [\#297](https://github.com/voxpupuli/puppet-kafka/pull/297) ([dhoppe](https://github.com/dhoppe))

**Fixed bugs:**

- Fix init script parameter bug [\#307](https://github.com/voxpupuli/puppet-kafka/pull/307) ([pmbuko](https://github.com/pmbuko))
- Match params of init script with the ones of systemd unit [\#281](https://github.com/voxpupuli/puppet-kafka/pull/281) ([tooooots](https://github.com/tooooots))

**Closed issues:**

- Incorrect tag style in init.erb template causes minor bug in generated file [\#306](https://github.com/voxpupuli/puppet-kafka/issues/306)
- config\_dir permissions not set, owned by root, kafka user can't read - kafka 2.5.0 [\#305](https://github.com/voxpupuli/puppet-kafka/issues/305)
- Add support for SLES / OpenSuSE [\#300](https://github.com/voxpupuli/puppet-kafka/issues/300)
- Support for Kafka 2.0.0? [\#280](https://github.com/voxpupuli/puppet-kafka/issues/280)

**Merged pull requests:**

- Refactor unit tests [\#313](https://github.com/voxpupuli/puppet-kafka/pull/313) ([dhoppe](https://github.com/dhoppe))
- Specify data types as deeply as possible [\#312](https://github.com/voxpupuli/puppet-kafka/pull/312) ([dhoppe](https://github.com/dhoppe))
- Use latest available version of ZooKeeper in acceptance tests [\#309](https://github.com/voxpupuli/puppet-kafka/pull/309) ([dhoppe](https://github.com/dhoppe))
- Allow deric/zookeeper 1.x [\#308](https://github.com/voxpupuli/puppet-kafka/pull/308) ([dhoppe](https://github.com/dhoppe))
- Use voxpupuli-acceptance [\#296](https://github.com/voxpupuli/puppet-kafka/pull/296) ([ekohl](https://github.com/ekohl))

## [v6.0.0](https://github.com/voxpupuli/puppet-kafka/tree/v6.0.0) (2020-04-07)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v5.3.0...v6.0.0)

**Breaking changes:**

- Drop Puppet 4 support [\#292](https://github.com/voxpupuli/puppet-kafka/pull/292) ([alexjfisher](https://github.com/alexjfisher))
- Update default version to 2.4.1 with scala 2.12 [\#291](https://github.com/voxpupuli/puppet-kafka/pull/291) ([alexjfisher](https://github.com/alexjfisher))

**Implemented enhancements:**

- Puppet-archive 3.0.0 support [\#256](https://github.com/voxpupuli/puppet-kafka/issues/256)

**Closed issues:**

- Is this module abandoned?  [\#290](https://github.com/voxpupuli/puppet-kafka/issues/290)
- New version/tag [\#289](https://github.com/voxpupuli/puppet-kafka/issues/289)
- Proxy Server Support [\#285](https://github.com/voxpupuli/puppet-kafka/issues/285)
- Root owns config directory \(but not files in it\), ignoring $user [\#273](https://github.com/voxpupuli/puppet-kafka/issues/273)
- check debian support [\#254](https://github.com/voxpupuli/puppet-kafka/issues/254)
- Documentation: OS Compability [\#244](https://github.com/voxpupuli/puppet-kafka/issues/244)

**Merged pull requests:**

- Fix puppet-lint `absolute_classname-check` [\#293](https://github.com/voxpupuli/puppet-kafka/pull/293) ([alexjfisher](https://github.com/alexjfisher))
- bump java version dependency [\#287](https://github.com/voxpupuli/puppet-kafka/pull/287) ([TheMeier](https://github.com/TheMeier))
- Clean up acceptance spec helper [\#286](https://github.com/voxpupuli/puppet-kafka/pull/286) ([ekohl](https://github.com/ekohl))
- Allow `puppet/archive` 4.x, `puppetlabs/java` 4.x and `puppetlabs/stdlib` 6.x [\#284](https://github.com/voxpupuli/puppet-kafka/pull/284) ([alexjfisher](https://github.com/alexjfisher))
- update spec\_helper\_acceptance to work with latest beaker [\#279](https://github.com/voxpupuli/puppet-kafka/pull/279) ([bastelfreak](https://github.com/bastelfreak))

## [v5.3.0](https://github.com/voxpupuli/puppet-kafka/tree/v5.3.0) (2018-07-07)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v5.2.0...v5.3.0)

**Implemented enhancements:**

- add debian 8/9 & ubuntu 16.04 support, drop 14.04 [\#267](https://github.com/voxpupuli/puppet-kafka/pull/267) ([bastelfreak](https://github.com/bastelfreak))
- Use closest mirrors [\#261](https://github.com/voxpupuli/puppet-kafka/pull/261) ([bjoernhaeuser](https://github.com/bjoernhaeuser))
- add support for topic configurations at creation time [\#260](https://github.com/voxpupuli/puppet-kafka/pull/260) ([TheMeier](https://github.com/TheMeier))

**Fixed bugs:**

- Use correct mirror url  [\#263](https://github.com/voxpupuli/puppet-kafka/pull/263) ([bjoernhaeuser](https://github.com/bjoernhaeuser))

**Merged pull requests:**

- Remove coveralls badge [\#268](https://github.com/voxpupuli/puppet-kafka/pull/268) ([bjoernhaeuser](https://github.com/bjoernhaeuser))
- Enable Acceptance tests [\#266](https://github.com/voxpupuli/puppet-kafka/pull/266) ([bjoernhaeuser](https://github.com/bjoernhaeuser))
- \[WIP\] enable acceptance tests [\#265](https://github.com/voxpupuli/puppet-kafka/pull/265) ([bastelfreak](https://github.com/bastelfreak))
- cleanup spec\_helper\_acceptance.rb [\#264](https://github.com/voxpupuli/puppet-kafka/pull/264) ([bastelfreak](https://github.com/bastelfreak))
- Add test for different kafka version [\#262](https://github.com/voxpupuli/puppet-kafka/pull/262) ([bjoernhaeuser](https://github.com/bjoernhaeuser))

## [v5.2.0](https://github.com/voxpupuli/puppet-kafka/tree/v5.2.0) (2018-06-24)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v5.1.0...v5.2.0)

**Implemented enhancements:**

- Some updates to be able to use an internal http mirror with proxy to download the .tar.gz archive [\#257](https://github.com/voxpupuli/puppet-kafka/pull/257) ([idrissneumann](https://github.com/idrissneumann))

**Fixed bugs:**

- Ensure the process is killed before finishing stop [\#135](https://github.com/voxpupuli/puppet-kafka/pull/135) ([elmendalerenda](https://github.com/elmendalerenda))

**Merged pull requests:**

- Remove docker nodesets [\#255](https://github.com/voxpupuli/puppet-kafka/pull/255) ([bastelfreak](https://github.com/bastelfreak))
- drop EOL OSs; fix puppet version range [\#253](https://github.com/voxpupuli/puppet-kafka/pull/253) ([bastelfreak](https://github.com/bastelfreak))

## [v5.1.0](https://github.com/voxpupuli/puppet-kafka/tree/v5.1.0) (2018-04-05)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v5.0.1...v5.1.0)

**Implemented enhancements:**

- Config files should not be world readable [\#249](https://github.com/voxpupuli/puppet-kafka/issues/249)
- Add options for more sensible config permissions; puppet stdlib to 4.22.0 [\#250](https://github.com/voxpupuli/puppet-kafka/pull/250) ([langesven](https://github.com/langesven))

## [v5.0.1](https://github.com/voxpupuli/puppet-kafka/tree/v5.0.1) (2018-03-28)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v5.0.0...v5.0.1)

**Merged pull requests:**

- bump puppet to latest supported version 4.10.0 [\#247](https://github.com/voxpupuli/puppet-kafka/pull/247) ([bastelfreak](https://github.com/bastelfreak))
- allow camptocamp/systemd 2.X [\#245](https://github.com/voxpupuli/puppet-kafka/pull/245) ([bastelfreak](https://github.com/bastelfreak))

## [v5.0.0](https://github.com/voxpupuli/puppet-kafka/tree/v5.0.0) (2017-12-12)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v4.0.0...v5.0.0)

**Breaking changes:**

- Kafka's default version should be the latest stable version [\#216](https://github.com/voxpupuli/puppet-kafka/issues/216)
- replaced service\_requires\_zookeeper by service\_requires [\#236](https://github.com/voxpupuli/puppet-kafka/pull/236) ([LionelCons](https://github.com/LionelCons))
- changed limit\_nofile from Integer to String [\#229](https://github.com/voxpupuli/puppet-kafka/pull/229) ([LionelCons](https://github.com/LionelCons))
- made variables consistent [\#223](https://github.com/voxpupuli/puppet-kafka/pull/223) ([LionelCons](https://github.com/LionelCons))
- change the mirror class to get script options via a hash \(just like consumer and producer\) [\#221](https://github.com/voxpupuli/puppet-kafka/pull/221) ([LionelCons](https://github.com/LionelCons))
- change the default Kafka version to 0.11.0.1 [\#217](https://github.com/voxpupuli/puppet-kafka/pull/217) ([LionelCons](https://github.com/LionelCons))
- remove support for Kafka \< 0.9.0.0 [\#215](https://github.com/voxpupuli/puppet-kafka/pull/215) ([LionelCons](https://github.com/LionelCons))

**Implemented enhancements:**

- It should be possible to specify arbitrary service dependencies [\#234](https://github.com/voxpupuli/puppet-kafka/issues/234)
- It should be possible to start a broker with the -daemon option [\#230](https://github.com/voxpupuli/puppet-kafka/issues/230)
- Kafka default script values should not be used [\#218](https://github.com/voxpupuli/puppet-kafka/issues/218)
- Kafka default values should not be used [\#208](https://github.com/voxpupuli/puppet-kafka/issues/208)
- use Wants instead of Requires [\#238](https://github.com/voxpupuli/puppet-kafka/pull/238) ([LionelCons](https://github.com/LionelCons))
- added a daemon\_start option to be able to start the broker with the -daemon option [\#231](https://github.com/voxpupuli/puppet-kafka/pull/231) ([LionelCons](https://github.com/LionelCons))
- made LimitNOFILE and LimitCORE fully configurable [\#227](https://github.com/voxpupuli/puppet-kafka/pull/227) ([LionelCons](https://github.com/LionelCons))

**Fixed bugs:**

- LimitNOFILE cannot be set to 'infinity' [\#228](https://github.com/voxpupuli/puppet-kafka/issues/228)

**Closed issues:**

- The systemd script should use Wants instead of Requires [\#237](https://github.com/voxpupuli/puppet-kafka/issues/237)
- LimitNOFILE and LimitCORE should be unset by default [\#232](https://github.com/voxpupuli/puppet-kafka/issues/232)
- Systemd limits should be configurable [\#226](https://github.com/voxpupuli/puppet-kafka/issues/226)
- The properties templates should be merged [\#224](https://github.com/voxpupuli/puppet-kafka/issues/224)
- Variable names should be simple and consistent [\#222](https://github.com/voxpupuli/puppet-kafka/issues/222)
- Mirror script options should be given as a hash [\#220](https://github.com/voxpupuli/puppet-kafka/issues/220)
- Support for Kafka \< 0.9 should be removed [\#214](https://github.com/voxpupuli/puppet-kafka/issues/214)
- params.pp contains unused parameters [\#211](https://github.com/voxpupuli/puppet-kafka/issues/211)

**Merged pull requests:**

- removed the \(undocumented\) hard-coded defaults for limit\_nofile and limit\_core [\#233](https://github.com/voxpupuli/puppet-kafka/pull/233) ([LionelCons](https://github.com/LionelCons))
- merged all the properties templates [\#225](https://github.com/voxpupuli/puppet-kafka/pull/225) ([LionelCons](https://github.com/LionelCons))
- remove the unneeded service default parameters [\#219](https://github.com/voxpupuli/puppet-kafka/pull/219) ([LionelCons](https://github.com/LionelCons))
- remove the unneeded broker, consumer and producer default parameters [\#213](https://github.com/voxpupuli/puppet-kafka/pull/213) ([LionelCons](https://github.com/LionelCons))
- remove unused parameters in params.pp [\#212](https://github.com/voxpupuli/puppet-kafka/pull/212) ([LionelCons](https://github.com/LionelCons))

## [v4.0.0](https://github.com/voxpupuli/puppet-kafka/tree/v4.0.0) (2017-10-17)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v3.2.0...v4.0.0)

**Implemented enhancements:**

- Adjust puppet version boundaries for puppet6 [\#209](https://github.com/voxpupuli/puppet-kafka/pull/209) ([bastelfreak](https://github.com/bastelfreak))
- Add support for TimeoutStopSec and ExecStop in the systemd unit file [\#207](https://github.com/voxpupuli/puppet-kafka/pull/207) ([LionelCons](https://github.com/LionelCons))
- Higher allowed version for module java and lower for zookeeper [\#205](https://github.com/voxpupuli/puppet-kafka/pull/205) ([hp197](https://github.com/hp197))

**Closed issues:**

- Kafka stopping should be configurable in the systemd unit file [\#206](https://github.com/voxpupuli/puppet-kafka/issues/206)

## [v3.2.0](https://github.com/voxpupuli/puppet-kafka/tree/v3.2.0) (2017-09-29)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v3.1.0...v3.2.0)

**Breaking changes:**

- renamed kafka::broker::topic to kafka::topic and added a bin\_dir param [\#189](https://github.com/voxpupuli/puppet-kafka/pull/189) ([LionelCons](https://github.com/LionelCons))
- The ZooKeeper service is not required by default anymore [\#184](https://github.com/voxpupuli/puppet-kafka/pull/184) ([LionelCons](https://github.com/LionelCons))
- Java is not installed by default anymore [\#181](https://github.com/voxpupuli/puppet-kafka/pull/181) ([LionelCons](https://github.com/LionelCons))

**Implemented enhancements:**

- Added manage\_user and manage\_group parameters [\#185](https://github.com/voxpupuli/puppet-kafka/pull/185) ([LionelCons](https://github.com/LionelCons))

**Fixed bugs:**

- Typo in init.erb [\#198](https://github.com/voxpupuli/puppet-kafka/issues/198)
- Fixed typo in init.erb [\#199](https://github.com/voxpupuli/puppet-kafka/pull/199) ([LionelCons](https://github.com/LionelCons))
- kafka::consumer now calls kafka::consumer::config [\#187](https://github.com/voxpupuli/puppet-kafka/pull/187) ([LionelCons](https://github.com/LionelCons))
- kafka::mirror::service does not inherit from ::kafka::params anymore [\#177](https://github.com/voxpupuli/puppet-kafka/pull/177) ([LionelCons](https://github.com/LionelCons))

**Closed issues:**

- There are parameter discrepancies amongst kafka::\*::service [\#192](https://github.com/voxpupuli/puppet-kafka/issues/192)
- There are parameter discrepancies between kafka::init and kafka::\*::install [\#190](https://github.com/voxpupuli/puppet-kafka/issues/190)
- The kafka::broker::topic defined type should rather be kafka::topic [\#188](https://github.com/voxpupuli/puppet-kafka/issues/188)
- The consumer class does not call its config subclass [\#186](https://github.com/voxpupuli/puppet-kafka/issues/186)
- The ZooKeeper service should not be required by default [\#183](https://github.com/voxpupuli/puppet-kafka/issues/183)
- Java should not be installed by default [\#180](https://github.com/voxpupuli/puppet-kafka/issues/180)
- include statements do not need quotes [\#178](https://github.com/voxpupuli/puppet-kafka/issues/178)
- mirror/service.pp should not inherit from ::kafka::params [\#176](https://github.com/voxpupuli/puppet-kafka/issues/176)
- Module user/group management should be optional [\#173](https://github.com/voxpupuli/puppet-kafka/issues/173)

**Merged pull requests:**

- fix mirror maker with new consumer [\#203](https://github.com/voxpupuli/puppet-kafka/pull/203) ([jacobmw](https://github.com/jacobmw))
- Update README.md [\#201](https://github.com/voxpupuli/puppet-kafka/pull/201) ([confiq](https://github.com/confiq))
- enable possibility of system users for kafka [\#197](https://github.com/voxpupuli/puppet-kafka/pull/197) ([Wayneoween](https://github.com/Wayneoween))
- MirrorMaker service needed path to .properties files [\#196](https://github.com/voxpupuli/puppet-kafka/pull/196) ([jacobmw](https://github.com/jacobmw))
- cleanup related to the service classes [\#193](https://github.com/voxpupuli/puppet-kafka/pull/193) ([LionelCons](https://github.com/LionelCons))
- cleanup related to the install classes [\#191](https://github.com/voxpupuli/puppet-kafka/pull/191) ([LionelCons](https://github.com/LionelCons))
- include statements do not need quotes [\#179](https://github.com/voxpupuli/puppet-kafka/pull/179) ([LionelCons](https://github.com/LionelCons))

## [v3.1.0](https://github.com/voxpupuli/puppet-kafka/tree/v3.1.0) (2017-07-19)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v3.0.0...v3.1.0)

**Implemented enhancements:**

- handle the user, group, user\_id and group\_id parameters consistently [\#172](https://github.com/voxpupuli/puppet-kafka/pull/172) ([LionelCons](https://github.com/LionelCons))
- the \*.properties configuration files are now owned by root [\#166](https://github.com/voxpupuli/puppet-kafka/pull/166) ([LionelCons](https://github.com/LionelCons))
- added a "bin\_dir" parameter to configure where the Kafka scripts are [\#159](https://github.com/voxpupuli/puppet-kafka/pull/159) ([LionelCons](https://github.com/LionelCons))
- Allow changing the LimitNOFILE parameter for systemd unit file [\#157](https://github.com/voxpupuli/puppet-kafka/pull/157) ([jacobmw](https://github.com/jacobmw))
- add support to kafka::broker logs dir [\#148](https://github.com/voxpupuli/puppet-kafka/pull/148) ([jolivares](https://github.com/jolivares))
- Add log.message.format.version to broker params [\#142](https://github.com/voxpupuli/puppet-kafka/pull/142) ([winks](https://github.com/winks))

**Fixed bugs:**

- create $package\_dir and $install\_directory ony when needed [\#167](https://github.com/voxpupuli/puppet-kafka/pull/167) ([LionelCons](https://github.com/LionelCons))
- fix wrong defaults for mirror/service.pp [\#164](https://github.com/voxpupuli/puppet-kafka/pull/164) ([LionelCons](https://github.com/LionelCons))
- declared service dependencies: Kafka requires networking and syslog [\#162](https://github.com/voxpupuli/puppet-kafka/pull/162) ([LionelCons](https://github.com/LionelCons))
- change ownership of the configuration directory [\#160](https://github.com/voxpupuli/puppet-kafka/pull/160) ([LionelCons](https://github.com/LionelCons))

**Closed issues:**

- The user and group are hard-coded in the service templates [\#171](https://github.com/voxpupuli/puppet-kafka/issues/171)
- The init script always requires the zookeeper service [\#168](https://github.com/voxpupuli/puppet-kafka/issues/168)
- The configuration files should be owned by root [\#165](https://github.com/voxpupuli/puppet-kafka/issues/165)
- mirror/service.pp gets some defaults from params.pp instead of mirror.pp [\#163](https://github.com/voxpupuli/puppet-kafka/issues/163)
- The Systemd unit file should declare dependencies [\#161](https://github.com/voxpupuli/puppet-kafka/issues/161)
- Centos 7 install [\#151](https://github.com/voxpupuli/puppet-kafka/issues/151)
- systemd config should not contain dependencies on zookeeper [\#150](https://github.com/voxpupuli/puppet-kafka/issues/150)
- The configuration directory should be owned by root [\#146](https://github.com/voxpupuli/puppet-kafka/issues/146)
- The "bin" directory is not configurable [\#145](https://github.com/voxpupuli/puppet-kafka/issues/145)
- Arbitrary shell variables cannot be set [\#144](https://github.com/voxpupuli/puppet-kafka/issues/144)
- Package-based installation creates useless directories [\#143](https://github.com/voxpupuli/puppet-kafka/issues/143)

**Merged pull requests:**

- Release 3.1.0 [\#175](https://github.com/voxpupuli/puppet-kafka/pull/175) ([bastelfreak](https://github.com/bastelfreak))
- added an $env parameter to control the environment passed to Kafka [\#170](https://github.com/voxpupuli/puppet-kafka/pull/170) ([LionelCons](https://github.com/LionelCons))
- the init script now uses the service\_requires\_zookeeper parameter [\#169](https://github.com/voxpupuli/puppet-kafka/pull/169) ([LionelCons](https://github.com/LionelCons))
- replace validate\_\* with datatypes [\#153](https://github.com/voxpupuli/puppet-kafka/pull/153) ([bastelfreak](https://github.com/bastelfreak))
- Add missing documentation [\#138](https://github.com/voxpupuli/puppet-kafka/pull/138) ([seanmalloy](https://github.com/seanmalloy))
- Add params to allow customizing user, group, and log\_dir [\#137](https://github.com/voxpupuli/puppet-kafka/pull/137) ([seanmalloy](https://github.com/seanmalloy))

## [v3.0.0](https://github.com/voxpupuli/puppet-kafka/tree/v3.0.0) (2017-02-13)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v2.3.0...v3.0.0)

**Implemented enhancements:**

- Add custom config dir [\#130](https://github.com/voxpupuli/puppet-kafka/pull/130) ([antyale](https://github.com/antyale))

## [v2.3.0](https://github.com/voxpupuli/puppet-kafka/tree/v2.3.0) (2017-02-11)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v2.2.0...v2.3.0)

**Closed issues:**

- broker.id should also be set in $logs\_dir/meta.properties [\#117](https://github.com/voxpupuli/puppet-kafka/issues/117)

**Merged pull requests:**

- allow using any mirror\_url if it ends with tgz [\#126](https://github.com/voxpupuli/puppet-kafka/pull/126) ([petetodo](https://github.com/petetodo))
- Bump dependencies [\#125](https://github.com/voxpupuli/puppet-kafka/pull/125) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Mirror url custom port [\#121](https://github.com/voxpupuli/puppet-kafka/pull/121) ([ellamdav](https://github.com/ellamdav))

## [v2.2.0](https://github.com/voxpupuli/puppet-kafka/tree/v2.2.0) (2016-12-25)

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/v2.1.0...v2.2.0)

**Closed issues:**

- master branch not tagged [\#120](https://github.com/voxpupuli/puppet-kafka/issues/120)
- Incompatibility beetween $install\_dir and $version params [\#98](https://github.com/voxpupuli/puppet-kafka/issues/98)

**Merged pull requests:**

- Fix bounding of puppet version in metadata [\#116](https://github.com/voxpupuli/puppet-kafka/pull/116) ([ghoneycutt](https://github.com/ghoneycutt))
- Fix puppet 4 versioncmp need for string [\#115](https://github.com/voxpupuli/puppet-kafka/pull/115) ([marclambrichs](https://github.com/marclambrichs))
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

- Document missing parameters [\#100](https://github.com/voxpupuli/puppet-kafka/pull/100) ([igalic](https://github.com/igalic))
- Fix incompatibility beetween $install\_dir and $version params [\#99](https://github.com/voxpupuli/puppet-kafka/pull/99) ([igalic](https://github.com/igalic))
- Add support for MirrorMaker abort.on.send.failure [\#97](https://github.com/voxpupuli/puppet-kafka/pull/97) ([SegFaultAX](https://github.com/SegFaultAX))
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

- Fix wrong syntax \(default value for ssl.enabled.protocols\) [\#70](https://github.com/voxpupuli/puppet-kafka/pull/70) ([jolivares](https://github.com/jolivares))
- Allow to set KAFKA\_OPTS [\#69](https://github.com/voxpupuli/puppet-kafka/pull/69) ([jolivares](https://github.com/jolivares))
- add the jmx\_opts and log4j\_opts to the init scripts [\#67](https://github.com/voxpupuli/puppet-kafka/pull/67) ([eliranbz](https://github.com/eliranbz))
- Removing broker gc opts [\#66](https://github.com/voxpupuli/puppet-kafka/pull/66) ([bjoernhaeuser](https://github.com/bjoernhaeuser))
- add the ability to optimize all the different roles, not just the broker [\#65](https://github.com/voxpupuli/puppet-kafka/pull/65) ([eliranbz](https://github.com/eliranbz))
- fix the mirror.unit template  [\#62](https://github.com/voxpupuli/puppet-kafka/pull/62) ([eliranbz](https://github.com/eliranbz))
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

[Full Changelog](https://github.com/voxpupuli/puppet-kafka/compare/b417ba3ca7ab51cf77392b496005f4d8dcd89e4c...v0.1.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
