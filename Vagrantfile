# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Multi-provider Vagrant for RHCSA-EX200 labs
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

Vagrant.configure("2") do |config|
  config.vm.box = "almalinux/9"

  config.vm.disk :disk, size: "5GB", name: "secondary_disk"

  config.vm.network "private_network", ip: "192.168.56.10"

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

  # Mount the local labs/ directory to /labs inside the guest VM
  # Provider-specific handling for best compatibility:
  # - Hyper-V: SMB (default on Windows)
  # - VirtualBox: vboxsf (or rsync fallback)
  # - libvirt: 9p or nfs
  config.vm.synced_folder "./labs", "/labs"

  # Hyper-V specific synced folder override (SMB)
  # Note: Do NOT hardcode smb_username/smb_password here.
  # Let Vagrant use the current Windows user's credentials (run PowerShell as Administrator).
  config.vm.provider "hyperv" do |h, override|
    override.vm.synced_folder "./labs", "/labs", type: "smb"
  end

  # Libvirt specific synced folder (use 9p for better Linux compatibility)
  config.vm.provider "libvirt" do |lv, override|
    override.vm.synced_folder "./labs", "/labs", type: "9p", accessmode: "mapped"
  end

  # Provisioning (runs for all providers)
  config.vm.provision "shell", inline: <<-SHELL
    echo "Setting executable permissions on all lab scripts..."
    chmod +x /labs/**/*.sh 2>/dev/null || true

    echo "Installing required packages for RHCSA labs..."
    dnf install -y policycoreutils-python-utils autofs nfs-utils &>/dev/null

    echo "Configuring local simulated NFS server..."
    mkdir -p /srv/nfs_export
    echo "RHCSA NFS Share Content" > /srv/nfs_export/nfs_test.txt
    chmod -R 777 /srv/nfs_export
    echo "/srv/nfs_export *(rw,sync,no_root_squash)" > /etc/exports
    exportfs -ar
    systemctl enable --now nfs-server &>/dev/null
  SHELL
end
