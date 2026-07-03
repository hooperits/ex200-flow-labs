#!/bin/bash
# Guest provisioning for RHCSA-EX200 labs (RHEL 10 / AlmaLinux 10)
# Captures DHCP IP from Hyper-V Default Switch and opens firewalld for web platform.

set -euo pipefail

EX200_STATE_DIR="/var/lib/ex200"
mkdir -p "$EX200_STATE_DIR"

# ---------------------------------------------------------------------------
# Wait for DHCP-assigned IPv4 on the default route interface
# ---------------------------------------------------------------------------
wait_for_dhcp_ip() {
  local guest_ip="" iface=""
  echo "Esperando IP DHCP del switch Hyper-V..."

  for _ in $(seq 1 30); do
    iface=$(ip -4 route show default 2>/dev/null | awk '{print $5; exit}')
    if [[ -n "$iface" ]]; then
      guest_ip=$(ip -4 -o addr show dev "$iface" scope global 2>/dev/null \
        | awk '{print $4}' | cut -d/ -f1 | head -1)
      if [[ -n "$guest_ip" && "$guest_ip" != "127.0.0.1" ]]; then
        export GUEST_IP="$guest_ip"
        export IFACE="$iface"
        echo "$GUEST_IP" | tee "$EX200_STATE_DIR/guest-ip" >/dev/null
        echo "$IFACE"  | tee "$EX200_STATE_DIR/guest-iface" >/dev/null
        echo "GUEST_IP=${GUEST_IP} (interfaz ${IFACE})"
        return 0
      fi
    fi
    sleep 2
  done

  echo "ERROR: No se obtuvo IP DHCP en 60 segundos." >&2
  return 1
}

# ---------------------------------------------------------------------------
# Open firewalld using the captured GUEST_IP variable
# ---------------------------------------------------------------------------
configure_firewall_for_web() {
  local guest_ip="${GUEST_IP:-}"
  local iface="${IFACE:-}"

  if [[ -z "$guest_ip" ]]; then
    echo "ERROR: GUEST_IP vacía; no se puede configurar firewalld." >&2
    return 1
  fi

  if ! systemctl is-active --quiet firewalld; then
    echo "firewalld inactivo; omitiendo reglas de firewall."
    return 0
  fi

  echo "Configurando firewalld para ${guest_ip} (puertos 8080, 7681)..."

  if [[ -n "$iface" ]]; then
    firewall-cmd --permanent --zone=public --change-interface="$iface" 2>/dev/null || true
  fi

  firewall-cmd --permanent --zone=public --add-port=8080/tcp 2>/dev/null || true
  firewall-cmd --permanent --zone=public --add-port=7681/tcp 2>/dev/null || true

  firewall-cmd --permanent --zone=public \
    --add-rich-rule="rule family=ipv4 destination address=${guest_ip} port port=8080 protocol=tcp accept" \
    2>/dev/null || true
  firewall-cmd --permanent --zone=public \
    --add-rich-rule="rule family=ipv4 destination address=${guest_ip} port port=7681 protocol=tcp accept" \
    2>/dev/null || true

  firewall-cmd --reload
  echo "firewalld configurado para destination address=${guest_ip}"
}

# ---------------------------------------------------------------------------
# Labs directory on a real virtual hard disk (instead of SMB share)
# ---------------------------------------------------------------------------
setup_labs_disk() {
  echo "Setting up /labs from virtual hard disk..."

  local labs_disk="" candidate part
  for candidate in /dev/sdc /dev/sdd; do
    if [[ -b "$candidate" ]]; then
      if blkid "$candidate" | grep -q LABSDATA || \
         (lsblk -b "$candidate" 2>/dev/null | grep -q '2G' && [[ "$candidate" != "/dev/sdb" ]]); then
        labs_disk="$candidate"
        break
      fi
    fi
  done

  if [[ -n "$labs_disk" ]]; then
    part="${labs_disk}1"
    if ! blkid "$part" 2>/dev/null | grep -q 'LABEL="LABSDATA"'; then
      echo "Formatting labs data disk ($labs_disk)..."
      parted -s "$labs_disk" mklabel gpt
      parted -s "$labs_disk" mkpart primary ext4 1MiB 100%
      mkfs.ext4 -L LABSDATA "$part" >/dev/null
    fi

    mkdir -p /labs
    mount -L LABSDATA /labs 2>/dev/null || mount "$part" /labs

    if ! grep -q 'LABEL=LABSDATA /labs' /etc/fstab 2>/dev/null; then
      echo 'LABEL=LABSDATA /labs ext4 defaults 0 0' >> /etc/fstab
    fi
  fi
}

bootstrap_labs() {
  local src_labs="" src_lib=""

  [[ -d /tmp/labs-bootstrap ]] && src_labs=/tmp/labs-bootstrap
  [[ -d /vagrant/labs ]]       && src_labs=/vagrant/labs
  [[ -d /tmp/lib-bootstrap ]]  && src_lib=/tmp/lib-bootstrap
  [[ -d /vagrant/lib ]]        && src_lib=/vagrant/lib

  if [[ -z "$src_labs" || ! -d "$src_labs" ]]; then
    echo "WARN: No se encontró fuente bootstrap de labs." >&2
    return 0
  fi

  mkdir -p /labs

  if [[ ! -d /labs/01-essential-tools ]]; then
    echo "Initial population of /labs from bootstrap..."
    rsync -a "$src_labs/" /labs/
    [[ -n "$src_lib" ]] && rsync -a "$src_lib/" /labs/lib/
    echo "labs_data_disk - mounted at /labs (internal virtual disk, no SMB for labs)" > /labs/.disk-info
    touch /labs/.populated
  fi

  rsync -a --delete --exclude '*/challenge/' "$src_labs/" /labs/
  [[ -n "$src_lib" ]] && rsync -a "$src_lib/" /labs/lib/

  local labdir lab
  for labdir in /labs/*/challenge; do
    [[ -d "$labdir" ]] || continue
    lab=$(basename "$(dirname "$labdir")")
    if [[ -d "$src_labs/$lab/challenge" ]]; then
      rsync -a --ignore-existing "$src_labs/$lab/challenge/" "$labdir/" || true
    fi
  done
}

persist_guest_ip_for_labs() {
  if [[ -n "${GUEST_IP:-}" && -d /labs ]]; then
    echo "$GUEST_IP" > /labs/.guest-ip
  fi
}

install_packages_and_cli() {
  echo "Setting executable permissions on all lab scripts..."
  find /labs -name '*.sh' -type f -exec chmod 755 {} + 2>/dev/null || true

  echo "Installing required packages for RHCSA labs (RHEL 10)..."
  dnf install -y policycoreutils-python-utils autofs nfs-utils rsync ttyd python3-pip curl &>/dev/null

  pip3 install --quiet fastapi uvicorn jinja2 markdown 2>/dev/null \
    || pip install --quiet fastapi uvicorn jinja2 markdown 2>/dev/null || true

  if [[ -f /tmp/ex200-guide-bin ]]; then
    install -m 755 /tmp/ex200-guide-bin /usr/local/bin/ex200-guide
  elif [[ -f /vagrant/bin/ex200-guide ]]; then
    install -m 755 /vagrant/bin/ex200-guide /usr/local/bin/ex200-guide
  fi
  ln -sf /usr/local/bin/ex200-guide /home/vagrant/ex200-guide 2>/dev/null || true
}

setup_nfs_simulation() {
  echo "Configuring local simulated NFS server..."
  mkdir -p /srv/nfs_export
  echo "RHCSA NFS Share Content" > /srv/nfs_export/nfs_test.txt
  chmod -R 777 /srv/nfs_export
  echo "/srv/nfs_export *(rw,sync,no_root_squash)" > /etc/exports
  exportfs -ar
  systemctl enable --now nfs-server &>/dev/null || true
}

deploy_web_platform() {
  echo "Deploying interactive guided platform (systemd services)..."

  rm -rf /opt/ex200-guide
  mkdir -p /opt/ex200-guide
  if [[ -d /tmp/interactive-platform ]]; then
    cp -r /tmp/interactive-platform/* /opt/ex200-guide/
  fi

  cat > /etc/systemd/system/ttyd.service << 'TTYD'
[Unit]
Description=ttyd - Share terminal over web
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/ttyd -p 7681 -W /bin/bash
Restart=always
User=vagrant

[Install]
WantedBy=multi-user.target
TTYD

  cat > /etc/systemd/system/ex200-guide.service << 'GUIDE'
[Unit]
Description=EX200 Interactive Web Guide
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
WorkingDirectory=/opt/ex200-guide
ExecStart=/usr/bin/python3 -m uvicorn main:app --host 0.0.0.0 --port 8080
Restart=always
User=vagrant
Environment=PYTHONUNBUFFERED=1

[Install]
WantedBy=multi-user.target
GUIDE

  systemctl daemon-reload
  systemctl enable --now ttyd.service ex200-guide.service
}

print_summary() {
  local guest_ip="${GUEST_IP:-unknown}"
  echo ""
  echo "==============================================="
  echo "EX200 Interactive Platform lista"
  echo "  GUEST_IP=${guest_ip}"
  echo "  Web guide:  http://${guest_ip}:8080/?lab=01"
  echo "  Terminal:   http://${guest_ip}:7681"
  echo "==============================================="
}

# --- Main ---
setup_labs_disk
bootstrap_labs
wait_for_dhcp_ip
configure_firewall_for_web
persist_guest_ip_for_labs
install_packages_and_cli
setup_nfs_simulation
deploy_web_platform
print_summary