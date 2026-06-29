# Research Notes: 05-networking-services

Analysis of network and time configuration on RHEL 9 VM.

## nmcli commands
Static IP configuration:
```bash
nmcli connection modify eth1 ipv4.addresses 192.168.56.20/24 ipv4.gateway 192.168.56.1 ipv4.dns 8.8.8.8 ipv4.method manual
nmcli connection up eth1
```

## Hostname configuration
Change hostname persistently:
```bash
hostnamectl set-hostname rhcsa-server
```

## Sincronización NTP (Chrony)
In RHEL 9, NTP client is `chronyd`. The config file is `/etc/chrony.conf`.
To query NTP synchronization state:
```bash
chronyc sources
chronyc tracking
```

## Cron Job Format
The format of a crontab entry:
`minute hour day_of_month month day_of_week command`
Every Monday at 3:00 AM:
`0 3 * * 1 echo "RHCSA Examen" >> /tmp/cron_test.txt`
