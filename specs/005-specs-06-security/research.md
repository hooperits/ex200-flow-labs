# Research Notes: 06-security-selinux

Analysis of firewall and SELinux control on RHEL 9 VM.

## firewalld commands
To open services and ports permanently:
```bash
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-port=82/tcp
firewall-cmd --reload
```

## SELinux contexts
To define a file context rule and apply it:
```bash
semanage fcontext -a -t httpd_sys_content_t "/var/www/custom_html(/.*)?"
restorecon -R -v /var/www/custom_html
```

## SELinux booleans
To list and set booleans:
```bash
getsebool httpd_enable_homedirs
setsebool -P httpd_enable_homedirs on
```
The `-P` flag makes the setting persistent across reboots.
