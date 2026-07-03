# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Multi-provider Vagrant for RHCSA-EX200 labs (RHEL 10 / AlmaLinux 10)
# Usage examples:
#   vagrant up                    # default provider (depends on env)
#   vagrant up --provider=virtualbox
#   vagrant up --provider=libvirt
#   vagrant up --provider=hyperv
#   vagrant up --provider=libvirt --no-parallel
#
# Requirements:
# - VirtualBox: common
# - libvirt: on Linux, vagrant-libvirt plugin
# - Hyper-V: on Windows, enable in features
#
# Labs synced to /labs inside guest.
# Base image: almalinux/10 (RHEL 10 compatible)

Vagrant.configure("2") do |config|
  config.vm.box = "almalinux/10"

  config.vm.disk :disk, size: "5GB", name: "secondary_disk"
  # Dedicated virtual hard disk for /labs (and /labs/lib). This replaces SMB synced
  # folders for the lab content on Hyper-V, giving us a real Linux filesystem so
  # chmod, chown, and stat behave correctly (fixes Lab 01 permission checks etc.).
  config.vm.disk :disk, size: "2GB", name: "labs_data_disk"

  config.vm.network "private_network", ip: "192.168.56.10"

  # Forward ports for the interactive web platform (so localhost:8080 and :7681 work on the host)
  # These are applied during VM creation
  config.vm.network "forwarded_port", guest: 7681, host: 7681, auto_correct: true
  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  # SSH forward (useful for some setups)
  config.vm.network "forwarded_port", guest: 22, host: 2222, auto_correct: true, id: "ssh"

  # After VM creation, ensure port forwarding works (especially useful on Hyper-V)
  # On Hyper-V this uses netsh portproxy as a reliable fallback
  config.trigger.after :up do |trigger|
    trigger.name = "Setup localhost access for interactive platform"
    trigger.info = "Making sure you can reach http://localhost:8080 and :7681"
    trigger.run = {
      inline: <<-POWERSHELL
        if ($env:OS -eq 'Windows_NT') {
          $ErrorActionPreference = "SilentlyContinue"
          $vmIp = "192.168.56.10"
          netsh interface portproxy delete v4tov4 listenport=8080 | Out-Null
          netsh interface portproxy add v4tov4 listenport=8080 connectport=8080 connectaddress=$vmIp | Out-Null
          netsh interface portproxy delete v4tov4 listenport=7681 | Out-Null
          netsh interface portproxy add v4tov4 listenport=7681 connectport=7681 connectaddress=$vmIp | Out-Null
          Write-Host "Port proxy configured for localhost:8080 and :7681 -> $vmIp"
        }
      POWERSHELL
    }
  end

  # Hyper-V (Windows)
  config.vm.provider "hyperv" do |h|
    h.enable_virtualization_extensions = true
    h.vmname = "RHCSA-EX200-flow-labs"
    h.memory = "2048"
    h.cpus = 2
  end

  # VirtualBox (macOS, Linux, Windows)
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.name = "RHCSA-EX200-flow-labs"
  end

  # Libvirt / KVM (Linux)
  config.vm.provider "libvirt" do |lv|
    lv.memory = "2048"
    lv.cpus = 2
    lv.nested = true
  end

  # NOTE: We no longer mount ./labs or ./lib via synced_folder as the primary
  # mechanism. Instead we use a dedicated virtual hard disk (see labs_data_disk above)
  # and populate it from the file provisions above. This gives a real Linux FS
  # so chmod/stat work reliably (especially important on Hyper-V).
  #
  # We still allow a /vagrant mount on non-Hyper-V for convenience during development.
  # On Hyper-V we disable it to completely avoid SMB when possible.

  # Bootstrap the labs and lib content via file provisioner (transfers over SSH/WinRM).
  # This is the source we will copy into the internal virtual disk at /labs.
  # Using file provision (instead of relying solely on synced_folder) lets us
  # avoid or minimize SMB for the actual /labs mount.
  config.vm.provision "file", source: "./labs", destination: "/tmp/labs-bootstrap"
  config.vm.provision "file", source: "./lib", destination: "/tmp/lib-bootstrap"
  config.vm.provision "file", source: "./interactive-platform", destination: "/tmp/interactive-platform"

  # Hyper-V: we deliberately avoid SMB for the labs content.
  # The labs + lib directories are delivered via the "file" provisioner above and
  # placed onto a real virtual hard disk (see labs_data_disk). This removes the
  # permission-mapping problems that SMB causes for chmod/stat.
  config.vm.provider "hyperv" do |h, override|
    # Fully disable the default project sync (and any remaining labs/lib) to
    # avoid SMB credential prompts and permission issues entirely for labs.
    override.vm.synced_folder ".", "/vagrant", disabled: true
  end

  # Libvirt specific (we still allow the default /vagrant for bootstrap convenience;
  # the labs disk logic below will take over for the actual /labs mount).
  config.vm.provider "libvirt" do |lv, override|
    # No special override needed for labs/lib anymore; disk-backed mount is used.
  end

  # Provisioning (runs for all providers)
  # RHEL 10 / AlmaLinux 10 notes:
  # - dnf now uses dnf5 under the hood (compatible for most commands)
  # - Package names for SELinux tools remain similar
  config.vm.provision "shell", inline: <<-SHELL
    # ==================================================================
    # Labs directory on a real virtual hard disk (instead of SMB share)
    # This gives us proper Unix permissions (chmod 640, stat, etc.).
    # See the labs_data_disk declaration in the Vagrantfile.
    # ==================================================================

    echo "Setting up /labs from virtual hard disk..."

    LABS_DISK=""
    for candidate in /dev/sdc /dev/sdd; do
      if [ -b "$candidate" ]; then
        if blkid "$candidate" | grep -q LABSDATA || \
           (lsblk -b "$candidate" 2>/dev/null | grep -q '2G' && [ "$candidate" != "/dev/sdb" ]); then
          LABS_DISK="$candidate"
          break
        fi
      fi
    done

    if [ -n "$LABS_DISK" ]; then
      PART="${LABS_DISK}1"
      if ! blkid "$PART" 2>/dev/null | grep -q 'LABEL="LABSDATA"'; then
        echo "Formatting labs data disk ($LABS_DISK)..."
        parted -s "$LABS_DISK" mklabel gpt
        parted -s "$LABS_DISK" mkpart primary ext4 1MiB 100%
        mkfs.ext4 -L LABSDATA "$PART" >/dev/null
      fi

      mkdir -p /labs
      mount -L LABSDATA /labs 2>/dev/null || mount "$PART" /labs

      if ! grep -q 'LABEL=LABSDATA /labs' /etc/fstab 2>/dev/null; then
        echo 'LABEL=LABSDATA /labs ext4 defaults 0 0' >> /etc/fstab
      fi
    fi

    # Determine bootstrap source (file provisioner or /vagrant)
    SRC_LABS=""
    SRC_LIB=""
    [ -d /tmp/labs-bootstrap ] && SRC_LABS=/tmp/labs-bootstrap
    [ -d /vagrant/labs ]       && SRC_LABS=/vagrant/labs
    [ -d /tmp/lib-bootstrap ]  && SRC_LIB=/tmp/lib-bootstrap
    [ -d /vagrant/lib ]        && SRC_LIB=/vagrant/lib

    if [ -n "$SRC_LABS" ] && [ -d "$SRC_LABS" ]; then
      # First boot / initial population
      if [ ! -d /labs/01-essential-tools ]; then
        echo "Initial population of /labs from bootstrap..."
        rsync -a "$SRC_LABS/" /labs/
        [ -n "$SRC_LIB" ] && rsync -a "$SRC_LIB/" /labs/lib/
        echo "labs_data_disk - mounted at /labs (internal virtual disk, no SMB for labs)" > /labs/.disk-info
        touch /labs/.populated
      fi

      # Refresh lab code without destroying student work in challenge/
      rsync -a --delete --exclude '*/challenge/' "$SRC_LABS/" /labs/
      [ -n "$SRC_LIB" ] && rsync -a "$SRC_LIB/" /labs/lib/

      # Restore any missing committed challenge/ skeletons (student files stay)
      for labdir in /labs/*/challenge; do
        lab=$(basename "$(dirname "$labdir")")
        if [ -d "$SRC_LABS/$lab/challenge" ]; then
          rsync -a --ignore-existing "$SRC_LABS/$lab/challenge/" "$labdir/" || true
        fi
      done
    fi

    # --- Original provisioning steps (now operating on disk-backed /labs) ---
    echo "Setting executable permissions on all lab scripts..."
    find /labs -name '*.sh' -type f -exec chmod 755 {} + 2>/dev/null || true

    echo "Installing required packages for RHCSA labs (RHEL 10)..."
    dnf install -y policycoreutils-python-utils autofs nfs-utils rsync ttyd python3-pip &>/dev/null

    # Install Python packages for the interactive web platform
    pip3 install --quiet fastapi uvicorn jinja2 markdown 2>/dev/null || pip install --quiet fastapi uvicorn jinja2 markdown 2>/dev/null || true

    # Install the CLI guide (for convenience)
    if [ -f /tmp/labs-bootstrap/../bin/ex200-guide ]; then
      install -m 755 /tmp/labs-bootstrap/../bin/ex200-guide /usr/local/bin/ex200-guide 2>/dev/null || true
    elif [ -f /vagrant/bin/ex200-guide ]; then
      install -m 755 /vagrant/bin/ex200-guide /usr/local/bin/ex200-guide 2>/dev/null || true
    fi
    ln -sf /usr/local/bin/ex200-guide /home/vagrant/ex200-guide 2>/dev/null || true

    # Start ttyd for the interactive guided platform (gold experience)
    # Exposes a real terminal in the browser on port 7681
    pkill ttyd 2>/dev/null || true
    nohup ttyd -p 7681 -W bash > /tmp/ttyd.log 2>&1 &

    echo "Configuring local simulated NFS server..."
    mkdir -p /srv/nfs_export
    echo "RHCSA NFS Share Content" > /srv/nfs_export/nfs_test.txt
    chmod -R 777 /srv/nfs_export
    echo "/srv/nfs_export *(rw,sync,no_root_squash)" > /etc/exports
    exportfs -ar
    systemctl enable --now nfs-server &>/dev/null

    # --- Interactive Web Platform (Gold experience) ---
    echo "Deploying and starting interactive guided platform (systemd services)..."

    # Deploy the web platform code
    rm -rf /opt/ex200-guide
    mkdir -p /opt/ex200-guide
    if [ -d /tmp/interactive-platform ]; then
        cp -r /tmp/interactive-platform/* /opt/ex200-guide/
    fi

    # Create systemd service for ttyd (real terminal on 7681)
    cat > /etc/systemd/system/ttyd.service << 'TTYD'
[Unit]
Description=ttyd - Share terminal over web
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/ttyd -p 7681 -W /bin/bash
Restart=always
User=vagrant

[Install]
WantedBy=multi-user.target
TTYD

    # Create systemd service for the web guide (FastAPI on 8080)
    cat > /etc/systemd/system/ex200-guide.service << 'GUIDE'
[Unit]
Description=EX200 Interactive Web Guide
After=network.target

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

    # Enable and start the services (this happens during VM creation)
    systemctl daemon-reload
    systemctl enable --now ttyd.service ex200-guide.service

    # Discover the actual IPv4 the VM received (critical for Hyper-V Default Switch / NAT)
    GUEST_IP=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -1 || echo "192.168.56.10")

    echo "Interactive platform ready (auto-starts on boot):"
    echo "  - Web guide UI:  http://$GUEST_IP:8080 (add ?lab=01)"
    echo "  - Real terminal: http://$GUEST_IP:7681"
    echo ""
    echo "From HOST: use the IP shown above (localhost forwarding can be flaky on Hyper-V)."
  SHELL

  # Nice message shown after successful creation
  config.vm.post_up_message = <<~MSG
    ===============================================
    EX200 Interactive Platform is ready!

    IMPORTANT (Hyper-V): Use the VM IP printed during provisioning, e.g.:
      http://<GUEST-IP>:8080/?lab=01     (guided web UI)
      http://<GUEST-IP>:7681             (raw terminal)

    Inside the VM:
      ex200-guide 01

    To discover the IP from host:
      vagrant ssh -c "ip -4 addr show | grep inet"
    ===============================================
  MSG
end
