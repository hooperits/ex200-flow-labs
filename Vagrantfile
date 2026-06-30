# -*- mode: ruby -*-
# vi: set ft=ruby :

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
  end

  # Mount the local labs/ directory to /labs inside the guest VM
  # Provider-specific handling for best compatibility:
  # - Hyper-V: SMB (default on Windows)
  # - VirtualBox: vboxsf (or rsync fallback)
  # - libvirt: 9p or nfs
  config.vm.synced_folder "./labs", "/labs"

  # Hyper-V specific synced folder override (SMB)
  config.vm.provider "hyperv" do |h, override|
    override.vm.synced_folder "./labs", "/labs", type: "smb", smb_username: "vagrant", smb_password: "vagrant"
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
