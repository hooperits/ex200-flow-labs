# Requirements Checklist: 09-podman-containers

Use this checklist to verify that all specifications are fully met.

## 📋 General Requirements
- [x] R-001: The feature directory has been resolved as `/specs/008-specs-09-podman/`
- [x] R-002: The branch is `008-specs-09-podman`

## 📋 Functional Requirements (Module 09)
- [x] FR-001: `demo.sh` illustrates rootless podman (`podman run`, `podman ps`), local directory mounts (`-v`), user systemd configurations, and loginctl linger activation.
- [x] FR-002: `demo.sh` implements clear screen transitions between sections (`clear_section`).
- [x] FR-003: `demo.sh` runs for at least 3 minutes (180 seconds) with appropriate typing and post-execution pauses.
- [x] FR-004: `instructions.md` details the challenge requirements in Spanish (running a rootless container named `web-app` using `httpd` or `nginx` image, mapping port `8080` to `80`, mounting directory `/home/vagrant/web_data` to `/var/www/html` or `/usr/share/nginx/html`, generating user systemd unit, and enabling lingering).
- [x] FR-005: `hints.md` provides progressive clues to solve the challenge.
- [x] FR-006: `verify.sh` automatically evaluates container status, user systemd configuration, and linger state.
- [x] FR-007: `reset.sh` cleans up podman containers, user systemd configurations, and lingers.
