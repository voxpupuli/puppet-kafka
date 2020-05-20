# Kafka module for Puppet

[![Build Status](https://travis-ci.org/voxpupuli/puppet-kafka.png?branch=master)](https://travis-ci.org/voxpupuli/puppet-kafka)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/kafka.svg)](https://forge.puppetlabs.com/puppet/kafka)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/kafka.svg)](https://forge.puppetlabs.com/puppet/kafka)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/kafka.svg)](https://forge.puppetlabs.com/puppet/kafka)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/kafka.svg)](https://forge.puppetlabs.com/puppet/kafka)

## Table of Contents

1. [Overview](#overview)
1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with Kafka](#setup)
    * [What Kafka affects](#what-kafka-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with Kafka](#beginning-with-kafka)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Overview

The Kafka module for managing the installation and configuration of [Apache Kafka](http://kafka.apache.org).

## Module Description

The Kafka module for managing the installation and configuration of Apache Kafka:
it's brokers, producers and consumers.

## Setup

### What Kafka affects

Installs the Kafka package and creates a new service.

### Setup requirements

This module has the following dependencies:

* [deric/zookeeper](https://github.com/deric/puppet-zookeeper)
* [camptocamp/systemd](https://github.com/camptocamp/puppet-systemd)
* [puppet/archive](https://github.com/voxpupuli/puppet-archive)
* [puppetlabs/java](https://github.com/puppetlabs/puppetlabs-java)
* [puppetlabs/stdlib](https://github.com/puppetlabs/puppetlabs-stdlib)

### Beginning with Kafka

To successfully install Kafka using this module you need to have Apache ZooKeeper
already running at localhost:2181. You can specify another ZooKeeper host:port
configuration using the config hash of the kafka::broker class.

The default configuration installs Kafka 0.11.0.3 binaries with Scala 2.11:

```puppet
  class { 'kafka': }
```

If you want a Kafka broker server that connects to ZooKeeper listening on port 2181:

```puppet
  class { 'kafka::broker':
    config => {
      'broker.id'         => '0',
      'zookeeper.connect' => 'localhost:2181'
    }
  }
```

## Usage

You can specify different Kafka binaries packages versions to install. Please
take a look at the different Scala and Kafka versions combinations at the
[Apache Kafka Website](http://kafka.apache.org/downloads.html)

### Installing Kafka version 1.1.0 with scala 2.12

We first install the binary package with:

```puppet
  class { 'kafka':
    version => '1.1.0',
    scala_version => '2.12'
  }
```

Then we set a minimal Kafka broker configuration with:

```puppet
  class { 'kafka::broker':
    config => {
      'broker.id'         => '0',
      'zookeeper.connect' => 'localhost:2181'
    }
  }
```

## Reference

The [reference][1] documentation of this module is generated using [puppetlabs/puppetlabs-strings][2].

## Limitations

This module only supports Kafka >= 0.9.0.0.

This module is tested on the following platforms:

* Debian 8
* Debian 9
* Debian 10
* Ubuntu 16.04
* Ubuntu 18.04
* CentOS 6
* CentOS 7

It is tested with the OSS version of Puppet (>= 5.5) only.

## Development

This module has grown over time based on a range of contributions from people
using it. If you follow these [contributing][3] guidelines your patch will
likely make it into a release a little more quickly.

## Author

This module is maintained by [Vox Pupuli][4]. It was originally written and
maintained by [Liam Bennett][5].

[1]: https://github.com/voxpupuli/puppet-kafka/blob/master/REFERENCE.md
[2]: https://github.com/puppetlabs/puppetlabs-strings
[3]: https://github.com/voxpupuli/puppet-kafka/blob/master/.github/CONTRIBUTING.md
[4]: https://voxpupuli.org
[5]: https://www.opentable.com