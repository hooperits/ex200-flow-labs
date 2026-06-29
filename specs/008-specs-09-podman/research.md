# Research Notes: 09-podman-containers

Analysis of rootless containers and systemd automation on RHEL 9 VM.

## Podman Rootless Execution
To run a container without root privileges:
```bash
podman run -d --name web-server -p 8080:8080 -v /home/vagrant/html:/usr/share/nginx/html:Z registry.access.redhat.com/ubi9/nginx-120
```
*Note*: The `:Z` flag on the volume is critical for SELinux relabeling of rootless volume mounts.

## User systemd integration
User systemd unit files must be placed in `~/.config/systemd/user/`.
Commands:
```bash
mkdir -p ~/.config/systemd/user/
cd ~/.config/systemd/user/
podman generate systemd --new --files --name web-server
systemctl --user daemon-reload
systemctl --user enable container-web-server.service
```

## loginctl Linger
Normally, user-level systemd daemons and containers terminate when the user logs out of their SSH session. To allow the container to start automatically at boot and keep running after logout:
```bash
loginctl enable-linger vagrant
```
Verification of linger status:
```bash
loginctl show-user vagrant | grep Linger
# or check
ls /var/lib/systemd/linger/vagrant
```
