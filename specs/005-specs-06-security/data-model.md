# Data Model and Test Scenarios: 06-security-selinux

Layout of test inputs and outputs.

## Firewall Rules
- Allowed service: `http`
- Allowed port: `82/tcp`
- Zone: `public` (default)

## SELinux path context
- Directory: `/var/www/custom_html`
- Context: `httpd_sys_content_t`

## SELinux boolean
- Target boolean: `httpd_enable_homedirs`
- Target state: `on` / `1`
