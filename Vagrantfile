# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Multi-provider Vagrant for RHCSA-EX200 labs (RHEL 10 / AlmaLinux 10)
# Usage examples:
#   vagrant up --provider=hyperv      # Windows: elegir Default Switch (DHCP)
#   vagrant up --provider=virtualbox
#   vagrant up --provider=libvirt
#
# Red: IP asignada por DHCP del switch/proveedor (sin IP estática).
# La IP se captura en provision-guest.sh y se usa para firewalld + acceso web.

Vagrant.configure("2") do |config|
  config.vm.box = "almalinux/10"

  config.vm.disk :disk, size: "5GB", name: "secondary_disk"
  config.vm.disk :disk, size: "2GB", name: "labs_data_disk"

  # Puertos de la plataforma web (útiles en VirtualBox/libvirt; Hyper-V usa portproxy dinámico)
  config.vm.network "forwarded_port", guest: 7681, host: 7681, auto_correct: true
  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 22, host: 2222, auto_correct: true, id: "ssh"

  config.vm.provider "hyperv" do |h, override|
    override.vm.synced_folder ".", "/vagrant", disabled: true
    h.vmname = "RHCSA-EX200-flow-labs"
    h.memory = 2048
    h.cpus = 2
    h.enable_virtualization_extensions = true
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
    vb.name = "RHCSA-EX200-flow-labs"
  end

  config.vm.provider "libvirt" do |lv|
    lv.memory = 2048
    lv.cpus = 2
    lv.nested = true
  end

  # Contenido de labs vía file provisioner (evita SMB en Hyper-V)
  config.vm.provision "file", source: "./labs", destination: "/tmp/labs-bootstrap"
  config.vm.provision "file", source: "./lib", destination: "/tmp/lib-bootstrap"
  config.vm.provision "file", source: "./interactive-platform", destination: "/tmp/interactive-platform"
  config.vm.provision "file", source: "./bin/ex200-guide", destination: "/tmp/ex200-guide-bin"
  config.vm.provision "file", source: "./scripts/diagnose-guest-web.sh", destination: "/tmp/ex200-diagnose"

  config.vm.provision "shell", inline: "install -m 755 /tmp/ex200-diagnose /usr/local/bin/ex200-diagnose"

  config.vm.provision "shell", path: "scripts/provision-guest.sh"

  # Hyper-V: portproxy dinámico hacia la IP DHCP real de la VM
  config.trigger.after :up do |trigger|
    trigger.name = "Configure Hyper-V portproxy with DHCP guest IP"
    trigger.run = {
      path: "scripts/configure-hyperv-portproxy.ps1"
    }
  end

  config.trigger.after :provision do |trigger|
    trigger.name = "Refresh Hyper-V portproxy after provision"
    trigger.run = {
      path: "scripts/configure-hyperv-portproxy.ps1"
    }
  end

  config.vm.post_up_message = <<~MSG
    ===============================================
    EX200 Interactive Platform

    Hyper-V: usa la IP DHCP impresa durante el aprovisionamiento:
      http://<GUEST-IP>:8080/?lab=01
      http://<GUEST-IP>:7681

    Descubrir IP:
      vagrant ssh -c "cat /var/lib/ex200/guest-ip"

    Diagnóstico (host Windows):
      .\\scripts\\diagnose-hyperv.ps1

    Diagnóstico (dentro de la VM):
      ex200-diagnose
    ===============================================
  MSG
end