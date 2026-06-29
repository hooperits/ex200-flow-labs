# Data Model and Test Scenarios: 05-networking-services

Layout of test inputs and outputs.

## Hostname
- Target name: `rhcsa-server`

## Network Connection
- Interface: `eth1` (or first secondary interface found, typically `eth1` or `enp0s8` depending on virtualizer. We will detect active interfaces dynamically in verify.sh).
- IP Target: `192.168.56.20`
- Netmask: `24`

## NTP config
- Expected peer: `pool.ntp.org`

## Cron job
- Syntax: `0 3 * * 1`
- Content: `cron_test.txt`
