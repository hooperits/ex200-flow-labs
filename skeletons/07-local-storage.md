# Esqueleto Video / Letras - 07-local-storage
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/07-local-storage/demo.sh
# Fecha: 2026-06-30
#
# Instrucciones:
# - Alinea con las letras en RHCSA-EX200-lyrics/.
# - Los tiempos son estimados (12s por comando aprox).
# - Ejecuta con `--video` para tiempos reales.
# - Comandos en inglés | Narrativa en español.

## Estructura sugerida del video/rap

### CORO / Intro
[00:00 - 00:00] - INTRO / GANCHO

[00:00 - 00:48] - ESTROFA 1: 1. Discos y Particiones

- **Listamos todos los dispositivos de bloque y discos instalados**
  ```
  lsblk
  ```

- **Mostramos información detallada de los sistemas de archivos montados**
  ```
  df -hT | head -n 6
  ```

- **Ejemplo de creación de partición GPT (interactivo)**
  ```
  echo 'gdisk /dev/sdb'   # gdisk es interactivo, se usa en el reto real
  ```

- **Ejemplo de creación de partición MBR (interactivo)**
  ```
  echo 'fdisk /dev/sdb'   # fdisk es interactivo
  ```

[00:48 - 01:36] - ESTROFA 2: 2. PV, VG y LV

- **Inicializamos /dev/sdb como Physical Volume (PV)**
  ```
  sudo pvcreate -f /dev/sdb
  ```

- **Listamos los PVs activos**
  ```
  sudo pvs
  ```

- **Creamos Volume Group (VG) vg_demo**
  ```
  sudo vgcreate -f vg_demo /dev/sdb
  ```

- **Creamos Logical Volume (LV) lv_demo de 200M**
  ```
  sudo lvcreate -L 200M -n lv_demo vg_demo
  ```

[01:36 - 02:36] - ESTROFA 3: 3. Formateo y Montaje

- **Formateamos el LV en XFS**
  ```
  sudo mkfs.xfs -f /dev/vg_demo/lv_demo
  ```

- **Creamos punto de montaje y montamos**
  ```
  sudo mkdir -p /mnt/demo && sudo mount /dev/vg_demo/lv_demo /mnt/demo
  ```

- **Mostramos el montaje**
  ```
  df -hT /mnt/demo
  ```

- **Extendemos el LV a 400M y redimensionamos FS**
  ```
  sudo lvextend -L 400M -r /dev/vg_demo/lv_demo
  ```

- **Verificamos el nuevo tamaño**
  ```
  df -hT /mnt/demo
  ```

[02:36 - 03:24] - ESTROFA 4: 4. LVM VDO

- **Ejemplo de creación de volumen VDO (requiere preparación)**
  ```
  echo 'sudo lvcreate --type vdo --name vdo_vol -L 1G -V 2G vg_demo'   # VDO optimizado
  ```

- **Mostramos LVs**
  ```
  sudo lvs
  ```

- **Ejemplo de formateo y montaje VDO**
  ```
  echo 'sudo mkfs.xfs /dev/vg_demo/vdo_vol && sudo mount /dev/vg_demo/vdo_vol /mnt/vdo'
  ```

- **Desmontamos y limpiamos para el demo**
  ```
  sudo umount /mnt/demo 2>/dev/null; sudo lvremove -f /dev/vg_demo/lv_demo 2>/dev/null; sudo vgremove -f vg_demo 2>/dev/null; sudo pvremove -f /dev/sdb 2>/dev/null; sudo rm -rf /mnt/demo
  ```

[03:24 - 03:24] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~3 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Discos y Particiones
- Listamos todos los dispositivos de bloque y discos instalados → lsblk
- Mostramos información detallada de los sistemas de archivos montados → df -hT | head -n 6
- Ejemplo de creación de partición GPT (interactivo) → echo 'gdisk /dev/sdb'   # gdisk es interactivo, se usa en el reto real
- Ejemplo de creación de partición MBR (interactivo) → echo 'fdisk /dev/sdb'   # fdisk es interactivo
ESTROFA: 2. PV, VG y LV
- Inicializamos /dev/sdb como Physical Volume (PV) → sudo pvcreate -f /dev/sdb
- Listamos los PVs activos → sudo pvs
- Creamos Volume Group (VG) vg_demo → sudo vgcreate -f vg_demo /dev/sdb
- Creamos Logical Volume (LV) lv_demo de 200M → sudo lvcreate -L 200M -n lv_demo vg_demo
ESTROFA: 3. Formateo y Montaje
- Formateamos el LV en XFS → sudo mkfs.xfs -f /dev/vg_demo/lv_demo
- Creamos punto de montaje y montamos → sudo mkdir -p /mnt/demo && sudo mount /dev/vg_demo/lv_demo /mnt/demo
- Mostramos el montaje → df -hT /mnt/demo
- Extendemos el LV a 400M y redimensionamos FS → sudo lvextend -L 400M -r /dev/vg_demo/lv_demo
- Verificamos el nuevo tamaño → df -hT /mnt/demo
ESTROFA: 4. LVM VDO
- Ejemplo de creación de volumen VDO (requiere preparación) → echo 'sudo lvcreate --type vdo --name vdo_vol -L 1G -V 2G vg_demo'   # VDO optimizado
- Mostramos LVs → sudo lvs
- Ejemplo de formateo y montaje VDO → echo 'sudo mkfs.xfs /dev/vg_demo/vdo_vol && sudo mount /dev/vg_demo/vdo_vol /mnt/vdo'
- Desmontamos y limpiamos para el demo → sudo umount /mnt/demo 2>/dev/null; sudo lvremove -f /dev/vg_demo/lv_demo 2>/dev/null; sudo vgremove -f vg_demo 2>/dev/null; sudo pvremove -f /dev/sdb 2>/dev/null; sudo rm -rf /mnt/demo

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
