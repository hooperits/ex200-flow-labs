# Esqueleto Video / Letras - 08-filesystems-network
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/08-filesystems-network/demo.sh
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

[00:00 - 00:48] - ESTROFA 1: 1. Identificación y Formateo de Archivos Locales

- **Listamos los UUIDs de todos los dispositivos de almacenamiento**
  ```
  sudo blkid | head -n 4
  ```

- **Mostramos las propiedades y tipos de los sistemas de archivos montados**
  ```
  findmnt -l --types ext4,xfs | head -n 5
  ```

- **Simulamos formatear un dispositivo usando mkfs.ext4**
  ```
  echo 'mkfs.ext4 /dev/sdb1'
  ```

- **Simulamos formatear un dispositivo usando mkfs.xfs**
  ```
  echo 'mkfs.xfs -f /dev/sdb1'
  ```

[00:48 - 01:36] - ESTROFA 2: 2. Montajes Persistentes en /etc/fstab

- **Visualizamos las líneas activas dentro de /etc/fstab**
  ```
  grep -v '^#' /etc/fstab | grep -v '^$'
  ```

- **Comprobamos el estado del montaje actual**
  ```
  mount | grep -E '^/dev/' | head -n 4
  ```

- **Simulamos cómo montar de forma segura todas las entradas de fstab**
  ```
  sudo mount -a
  ```

- **Simulamos cómo desmontar un dispositivo de forma segura**
  ```
  echo 'umount /mnt/docs'
  ```

[01:36 - 02:24] - ESTROFA 3: 3. Montajes Manuales de Red (NFS y SMB)

- **Buscamos paquetes cliente de NFS instalados en la VM**
  ```
  rpm -qa | grep nfs-utils || echo 'nfs-utils no instalado'
  ```

- **Simulamos cómo montar de forma manual un recurso NFS remoto**
  ```
  echo 'mount -t nfs 192.168.56.10:/exports /mnt/nfs'
  ```

- **Simulamos cómo montar un recurso compartido de red Windows (SMB/CIFS)**
  ```
  echo 'mount -t cifs -o username=user //192.168.56.10/share /mnt/smb'
  ```

- **Listamos los recursos NFS exportados por un servidor usando showmount**
  ```
  echo 'showmount -e 192.168.56.10'
  ```

[02:24 - 03:12] - ESTROFA 4: 4. Automontajes Dinámicos con Autofs

- **Comprobamos el estado del daemon autofs**
  ```
  systemctl status autofs 2>/dev/null || echo 'autofs no activo o no instalado'
  ```

- **Leemos el mapa maestro principal de autofs**
  ```
  cat /etc/auto.master 2>/dev/null || echo '/etc/auto.master no existe'
  ```

- **Simulamos la estructura de un mapa de mapeo secundario**
  ```
  echo 'nfs_share  -fstype=nfs,rw  192.168.56.10:/exports'
  ```

- **Simulamos cómo recargar y probar el automontaje en caliente**
  ```
  echo 'systemctl restart autofs && cd /shares/nfs_share'
  ```

[03:12 - 03:12] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~3 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap agresivo en español con un flujo chopper de velocidad máxima, rimas multisilábicas muy densas y complejas, dicción impecable incluso a alta velocidad y un estilo técnico, preciso y agresivo con gran complejidad rítmica y alto nivel técnico.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Identificación y Formateo de Archivos Locales
- Listamos los UUIDs de todos los dispositivos de almacenamiento → sudo blkid | head -n 4
- Mostramos las propiedades y tipos de los sistemas de archivos montados → findmnt -l --types ext4,xfs | head -n 5
- Simulamos formatear un dispositivo usando mkfs.ext4 → echo 'mkfs.ext4 /dev/sdb1'
- Simulamos formatear un dispositivo usando mkfs.xfs → echo 'mkfs.xfs -f /dev/sdb1'
ESTROFA: 2. Montajes Persistentes en /etc/fstab
- Visualizamos las líneas activas dentro de /etc/fstab → grep -v '^#' /etc/fstab | grep -v '^$'
- Comprobamos el estado del montaje actual → mount | grep -E '^/dev/' | head -n 4
- Simulamos cómo montar de forma segura todas las entradas de fstab → sudo mount -a
- Simulamos cómo desmontar un dispositivo de forma segura → echo 'umount /mnt/docs'
ESTROFA: 3. Montajes Manuales de Red (NFS y SMB)
- Buscamos paquetes cliente de NFS instalados en la VM → rpm -qa | grep nfs-utils || echo 'nfs-utils no instalado'
- Simulamos cómo montar de forma manual un recurso NFS remoto → echo 'mount -t nfs 192.168.56.10:/exports /mnt/nfs'
- Simulamos cómo montar un recurso compartido de red Windows (SMB/CIFS) → echo 'mount -t cifs -o username=user //192.168.56.10/share /mnt/smb'
- Listamos los recursos NFS exportados por un servidor usando showmount → echo 'showmount -e 192.168.56.10'
ESTROFA: 4. Automontajes Dinámicos con Autofs
- Comprobamos el estado del daemon autofs → systemctl status autofs 2>/dev/null || echo 'autofs no activo o no instalado'
- Leemos el mapa maestro principal de autofs → cat /etc/auto.master 2>/dev/null || echo '/etc/auto.master no existe'
- Simulamos la estructura de un mapa de mapeo secundario → echo 'nfs_share  -fstype=nfs,rw  192.168.56.10:/exports'
- Simulamos cómo recargar y probar el automontaje en caliente → echo 'systemctl restart autofs && cd /shares/nfs_share'

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
