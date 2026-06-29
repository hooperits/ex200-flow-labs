# Implementation Plan: 09-podman-containers

Detailed design for Module 09 - Podman Containers.

## User Review Required
None. Standard design according to constitution.

## Proposed Changes

### Labs Folder

#### [NEW] [demo.sh](file:///home/juanca/proys/RHCSA-EX200/labs/09-podman-containers/demo.sh)
Interactive container and Podman tutorial showing:
- Image management: `podman search`, `podman pull`.
- Container life: `podman run`, `podman ps`, `podman stop`, `podman rm`.
- Rootless systemd: `podman generate systemd --new --files --name`.
- Linger: `loginctl enable-linger`.

#### [NEW] [instructions.md](file:///home/juanca/proys/RHCSA-EX200/labs/09-podman-containers/instructions.md)
Detailed guidelines in Spanish for:
1. Downloading registry image `registry.access.redhat.com/ubi9/nginx-120` or similar public image (e.g. `docker.io/library/nginx:alpine` or `httpd:alpine`).
2. Running a rootless container named `web-server` mapping host port `8080` to container port `8080` (or 80), and mounting host directory `/home/vagrant/html` to `/usr/share/nginx/html` (or Apache directory).
3. Configuring user systemd directory: `mkdir -p ~/.config/systemd/user/`.
4. Generating systemd unit file using `podman generate systemd --new --files --name web-server` inside that folder.
5. Enabling the service at user level: `systemctl --user enable container-web-server.service`.
6. Enforcing linger for the `vagrant` user: `sudo loginctl enable-linger vagrant` (so the container starts at boot without ssh logins).

#### [NEW] [hints.md](file:///home/juanca/proys/RHCSA-EX200/labs/09-podman-containers/hints.md)
Pistas for `podman run -d`, `-v` flag, `podman generate systemd`, and `loginctl`.

#### [NEW] [verify.sh](file:///home/juanca/proys/RHCSA-EX200/labs/09-podman-containers/verify.sh)
Validates:
- Container `web-server` is configured to run rootless.
- Service file `container-web-server.service` exists in `/home/vagrant/.config/systemd/user/` and is enabled.
- User `vagrant` has linger enabled: `/var/lib/systemd/linger/vagrant` exists.

#### [NEW] [reset.sh](file:///home/juanca/proys/RHCSA-EX200/labs/09-podman-containers/reset.sh)
Stops and removes user systemd unit, removes the container, disables lingering, and deletes `/home/vagrant/html`.

## Verification Plan

### Manual Verification
- Run verify.sh before solving (should fail).
- Solve the challenge and check verify.sh (should pass).
- Check demo.sh duration is at least 3 minutes.
