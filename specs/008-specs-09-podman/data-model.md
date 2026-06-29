# Data Model and Test Scenarios: 09-podman-containers

Layout of test inputs and outputs.

## Container
- Name: `web-server`
- Image: `registry.access.redhat.com/ubi9/nginx-120` (or similar)
- Port: `8080` (host) to `8080` (container)
- Volume: `/home/vagrant/html` mounted on `/usr/share/nginx/html`

## Systemd User Service
- Service name: `container-web-server.service`
- Path: `/home/vagrant/.config/systemd/user/container-web-server.service`

## Linger config
- Path: `/var/lib/systemd/linger/vagrant` (must exist).
