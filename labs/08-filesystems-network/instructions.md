# Reto Práctico: Sistemas de Archivos Locales y Montajes de Red (Módulo 08)

Este reto evalúa tu capacidad para gestionar sistemas de archivos locales usando montajes por UUID, configurar montajes de red (NFS) y automatizar el montaje dinámico bajo demanda utilizando `autofs` en AlmaLinux 10 / RHEL 10.

**Nota RHEL 10**: fstab y autofs funcionan igual. El NFS simulado en el aprovisionamiento es compatible.

## Objetivos del Reto

Realiza las siguientes tareas de configuración:

1. **Montaje Local Persistente por UUID**:
   * Para simular un disco local, se ha provisto el dispositivo `/dev/sdb` (o puedes usar un archivo de loopback local para pruebas si `/dev/sdb` ya está en uso).
   * Identifica el **UUID** del dispositivo asignado (puedes verificar con `blkid`).
   * Configura el archivo `/etc/fstab` para montar este dispositivo de forma persistente en `/mnt/data_local` (debes crearlo tú mismo) usando **exclusivamente su UUID** (no uses el nombre del dispositivo `/dev/...`).
   * El sistema de archivos debe ser **`ext4`**.

2. **Configurar Autofs para Automontaje NFS**:
   * Instala el servicio `autofs` en el sistema (usando `dnf`).
   * Configura un punto de montaje dinámico bajo demanda en el directorio raíz **`/shares`**:
     * En el mapa maestro `/etc/auto.master`, agrega una línea que defina que `/shares` se gestiona por el archivo de mapa `/etc/auto.shares`.
     * En el archivo de mapa `/etc/auto.shares`, agrega una regla para el subdirectorio **`nfs_share`** que monte de forma automática (lectura y escritura) el recurso compartido simulado en tu propio servidor local: **`localhost:/srv/nfs_export`** (tipo de sistema de archivos `nfs`).
   * Asegúrate de que el servicio `autofs` esté habilitado y corriendo.
   * *Nota*: Para simular el servidor NFS, la VM ya viene con un export local en `/srv/nfs_export` listo para ser consumido.

## Evaluación

Una vez completadas todas las configuraciones, valida tu solución ejecutando:

```bash
./verify.sh
```

Puedes ver pistas progresivas en `hints.md` y restablecer el entorno a su estado original con `./reset.sh`.

