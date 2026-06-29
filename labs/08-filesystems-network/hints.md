# Pistas del Reto: 08-filesystems-network

## 1. Identificar UUID y montar localmente
* Formatea el disco si no está formateado:
  ```bash
  sudo mkfs.ext4 /dev/sdb
  ```
* Obtén el UUID ejecutando:
  ```bash
  sudo blkid /dev/sdb
  ```
* Crea el punto de montaje: `sudo mkdir -p /mnt/data_local`.
* Añade la entrada en `/etc/fstab`:
  ```text
  UUID=tu-uuid-aqui  /mnt/data_local  ext4  defaults  0 0
  ```
* Verifica el montaje: `sudo mount -a`.

## 2. Configurar autofs
* Instala el paquete:
  ```bash
  sudo dnf install -y autofs nfs-utils
  ```
* Edita `/etc/auto.master` y añade al final:
  ```text
  /shares  /etc/auto.shares
  ```
* Crea y edita `/etc/auto.shares`:
  ```text
  nfs_share  -fstype=nfs,rw  localhost:/srv/nfs_export
  ```
* Inicia y habilita el daemon:
  ```bash
  sudo systemctl enable --now autofs
  ```
* Comprueba si funciona simplemente cambiando de directorio (autofs creará la carpeta `nfs_share` dinámicamente cuando intentes acceder):
  ```bash
  cd /shares/nfs_share
  ls -la
  ```
