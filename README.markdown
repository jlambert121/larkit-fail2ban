#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with fail2ban](#setup)
    * [What fail2ban affects](#what-fail2ban-affects)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A puppet module to install/manage fail2ban.  This is tested with the [puppetlabs-firewall](https://github.com/puppetlabs/puppetlabs-firewall) module.

## Module Description

Fail2ban scans log files for failed logins and adds those IP addresses to iptables to drop future connections.  This puppet module enables fail2ban on a machine and supports custom actions, jails, and filters.

## Setup

### What fail2ban affects

* fail2ban package and service
* fail2ban configuration files

## Usage

To install fail2ban and enable the pre-defined ssh jail:

```puppet
  class { 'fail2ban': }
  fail2ban::jail { 'sshd': }
```

## Reference

### Public methods

#### Class: fail2ban

Main class for installing fail2ban

#####`version`

String.  Version to install

#####`config_dir`

String.  Root configuration directory for fail2ban

#####`log_leve`

String.  Log level to run fail2ban in

#####`ignoreip`

String.  Space separated list of IP addresses to ignore

#####`bantime`

Integer.  Time in seconds to ban an IP address

#####`findtime`

Integer.  Window size (in seconds) to consider IP addresses for failures

#####`maxretry`

Integer.  Number of times in `findtime` the IP address should have a failure before being banned for `bantime`

#####`backend`

String.  Backend to use when watching log files

#####`banaction`

String.  Backend to use for banning IPs


## Limitations

Tested on CentOS 6.7, CentOS 7

## Development

Improvements and bug fixes are greatly appreciated.  See the [contributing guide](https://github.com/LarkIT/larkit-fail2ban/CONTRIBUTING.md) for information on adding and validating tests for PRs.
