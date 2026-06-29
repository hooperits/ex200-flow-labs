# Quickstart Guide: 06-security-selinux

Guide to run and solve Module 06.

## How to execute

1. SSH into the VM:
   ```powershell
   vagrant ssh
   ```
2. Navigate to directory:
   ```bash
   cd /labs/06-security-selinux/
   ```
3. Run the interactive demo:
   ```bash
   ./demo.sh
   ```
4. Solve the challenge:
   - Run `sudo firewall-cmd --permanent --add-service=http`.
   - Run `sudo firewall-cmd --permanent --add-port=82/tcp`.
   - Reload firewall: `sudo firewall-cmd --reload`.
   - Create folder `sudo mkdir -p /var/www/custom_html`.
   - Define custom context: `sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/custom_html(/.*)?"`.
   - Restore context: `sudo restorecon -R -v /var/www/custom_html`.
   - Set boolean: `sudo setsebool -P httpd_enable_homedirs on`.
5. Run the validator:
   ```bash
   ./verify.sh
   ```
