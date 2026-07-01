# Pistas del Reto: 07-local-storage

## 1. Configuración Inicial de LVM
* Inicializa el disco físico `/dev/sdb`:
  ```bash
  sudo pvcreate /dev/sdb
  ```
* Crea el Volume Group:
  ```bash
  sudo vgcreate vg_labs /dev/sdb
  ```
* Crea el volumen de `800M`:
  ```bash
  sudo lvcreate -L 800M -n lv_docs vg_labs
  ```
* Dale formato:
  ```bash
  sudo mkfs.xfs /dev/vg_labs/lv_docs
  ```

## 2. Montajes Persistentes en /etc/fstab
* Crea el punto de montaje: `sudo mkdir -p /mnt/docs`.
* Añade la línea en `/etc/fstab`:
  ```text
  /dev/vg_labs/lv_docs  /mnt/docs  xfs  defaults  0 0
  ```
* Monta usando `sudo mount -a`.

## 3. Extensión de Volumen Lógico en Caliente
* Crea `lv_data`: `sudo lvcreate -L 500M -n lv_data vg_labs`.
* Dale formato: `sudo mkfs.xfs /dev/vg_labs/lv_data`.
* Para extender el volumen a `1G` y redimensionar el sistema de archivos a la vez, usa el parámetro `-r`:
  ```bash
  sudo lvextend -L 1G -r /dev/vg_labs/lv_data
  ```

## 4. Crear Volumen LVM VDO
* Para crear un volumen VDO con compresión y deduplicación en RHEL 10:
  ```bash
  sudo lvcreate --type vdo --name vdo_vol -L 4G -V 8G vg_labs
  ```
* Dale formato:
  ```bash
  sudo mkfs.xfs /dev/vg_labs/vdo_vol
  ```
* Crea punto de montaje: `sudo mkdir -p /mnt/vdo`.
* Añade la línea en `/etc/fstab`:
  ```text
  /dev/vg_labs/vdo_vol  /mnt/vdo  xfs  defaults  0 0
  ```
