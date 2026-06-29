# Implementation Plan: 06-security-selinux

Detailed design for Module 06 - Security and SELinux.

## User Review Required
None. Standard design according to constitution.

## Proposed Changes

### Labs Folder

#### [NEW] [demo.sh](file:///home/juanca/proys/RHCSA-EX200/labs/06-security-selinux/demo.sh)
Interactive security and SELinux tutorial showing:
- Firewalld: `firewall-cmd --get-active-zones`, `firewall-cmd --list-all`, `firewall-cmd --add-service`, `firewall-cmd --add-port`.
- SELinux contexts: `getenforce`, `ls -Z`, `semanage fcontext -l`, `restorecon -v`.
- SELinux ports: `semanage port -l`, `semanage port -a -t http_port_t -p tcp`.
- SELinux booleans: `getsebool -a`, `setsebool -P`.

#### [NEW] [instructions.md](file:///home/juanca/proys/RHCSA-EX200/labs/06-security-selinux/instructions.md)
Detailed guidelines in Spanish for:
1. Configuring firewalld to permanently allow traffic for the service `http` and port `82/tcp` in the `public` zone.
2. Restoring the context of a custom directory `/var/www/custom_html` and its files (created by the user) to be readable by Apache (`httpd_sys_content_t`).
3. Configuring a SELinux boolean `httpd_enable_homedirs` to be enabled persistently (`on`).

#### [NEW] [hints.md](file:///home/juanca/proys/RHCSA-EX200/labs/06-security-selinux/hints.md)
Pistas for `firewall-cmd --permanent`, `semanage fcontext`, `restorecon`, and `setsebool -P`.

#### [NEW] [verify.sh](file:///home/juanca/proys/RHCSA-EX200/labs/06-security-selinux/verify.sh)
Validates:
- Firewall rules: `http` and `82/tcp` are allowed permanently.
- Context of `/var/www/custom_html` is `httpd_sys_content_t`.
- Boolean `httpd_enable_homedirs` is enabled (`on` / `1`).

#### [NEW] [reset.sh](file:///home/juanca/proys/RHCSA-EX200/labs/06-security-selinux/reset.sh)
Cleans up firewall rules, resets SELinux boolean to default (`off`), and removes `/var/www/custom_html`.

## Verification Plan

### Manual Verification
- Run verify.sh before solving (should fail).
- Solve the challenge and check verify.sh (should pass).
- Check demo.sh duration is at least 3 minutes.
