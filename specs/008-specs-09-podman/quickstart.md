# Quickstart Guide: 09-podman-containers

Guide to run and solve Module 09.

## How to execute

1. SSH into the VM:
   ```powershell
   vagrant ssh
   ```
2. Navigate to directory:
   ```bash
   cd /labs/09-podman-containers/
   ```
3. Run the interactive demo:
   ```bash
   ./demo.sh
   ```
4. Solve the challenge:
   - Create local directory: `mkdir -p /home/vagrant/html`.
   - Run container rootless: `podman run -d --name web-server -p 8080:8080 -v /home/vagrant/html:/usr/share/nginx/html:Z registry.access.redhat.com/ubi9/nginx-120`.
   - Generate unit files:
     `mkdir -p ~/.config/systemd/user/`
     `cd ~/.config/systemd/user/`
     `podman generate systemd --new --files --name web-server`
   - Enable user service: `systemctl --user enable container-web-server.service`.
   - Enable linger: `sudo loginctl enable-linger vagrant`.
5. Run the validator:
   ```bash
   ./verify.sh
   ```
