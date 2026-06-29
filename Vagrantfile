# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "almalinux/9"

  config.vm.disk :disk, size: "5GB", name: "secondary_disk"

  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provider "hyperv" do |h|
    h.enable_virtualization_extensions = true
    h.vmname = "RHCSA-EX200-flow-labs"
    h.memory = "2048"
    h.cpus = 2
  end

  # Mount the local labs/ directory to /labs inside the guest VM
  # Using SMB (native Windows sharing for Hyper-V)
  config.vm.synced_folder "./labs", "/labs", type: "smb"

  # Provisioning to ensure correct script execution permissions on mount
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
