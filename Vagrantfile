# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "rockylinux/9"

  config.vm.provider "hyperv" do |h|
    h.enable_virtualization_extensions = true
    h.vmname = "RHCSA-EX200-flow-labs"
    h.memory = "2048"
    h.cpus = 2
  end

  # Mount the local labs/ directory to /labs inside the Rocky Linux 9 guest VM
  # Using rsync to avoid credential prompts with Hyper-V on Windows
  config.vm.synced_folder "./labs", "/labs", type: "rsync", rsync__exclude: [".git/", ".vagrant/"]

  # Provisioning to ensure correct script execution permissions on mount
  config.vm.provision "shell", inline: <<-SHELL
    echo "Setting executable permissions on all lab scripts..."
    chmod +x /labs/**/*.sh 2>/dev/null || true
  SHELL
end
