# Research Notes: 03-operating-systems

Analysis of systemd and process control on RHEL 9 VM.

## Custom systemd service creation
A systemd service requires a unit file under `/etc/systemd/system/`. Example format:
```ini
[Unit]
Description=Simple Python Web Server
After=network.target

[Service]
ExecStart=/usr/bin/python3 -m http.server 8080
Restart=on-failure

[Install]
WantedBy=multi-user.target
```
Commands to manage:
- `systemctl daemon-reload`
- `systemctl enable --now simple-web.service`

## System Target Configuration
Change default boot environment:
- View: `systemctl get-default`
- Set: `systemctl set-default multi-user.target` (non-graphical terminal mode).

## Root Password Recovery sequence
Under GRUB boot menu:
1. Press `e` on kernel line.
2. Find line starting with `linux` or `linux16`.
3. Append `rd.break` at the end of the line. Press `Ctrl+X` to boot.
4. Mount sysroot with write permission: `mount -o remount,rw /sysroot`
5. Switch to sysroot environment: `chroot /sysroot`
6. Reset password: `passwd`
7. Create SELinux relabel trigger: `touch /.autorelabel`
8. Exit and reboot.
