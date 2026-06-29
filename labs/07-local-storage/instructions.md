# Reto Práctico: Configuración de Almacenamiento Local y LVM (Módulo 07)

Este reto evalúa tu capacidad para gestionar discos físicos, particiones, volúmenes lógicos (LVM) y la optimización de almacenamiento con VDO en Rocky/AlmaLinux 9.

## Objetivos del Reto

Realiza las siguientes configuraciones de almacenamiento local (puedes usar un disco secundario libre, como `/dev/sdb`, el cual ya está incorporado en tu VM):

1. **Creación del Grupo de Volúmenes (Volume Group)**:
   * Inicializa el dispositivo `/dev/sdb` como Physical Volume (PV).
   * Crea un Volume Group (VG) llamado **`vg_labs`** utilizando el PV anterior.

2. **Creación y Montaje de un Volumen Lógico**:
   * Crea un Logical Volume (LV) llamado **`lv_docs`** dentro de `vg_labs` con un tamaño de **`800M`**.
   * Dale formato de sistema de archivos **`xfs`** al volumen.
   * Configura el sistema de forma que se monte automáticamente en el arranque en el directorio **`/mnt/docs`** (debes crearlo tú mismo) usando `/etc/fstab`.

3. **Extensión en Caliente**:
   * Crea un Logical Volume llamado **`lv_data`** en `vg_labs` con un tamaño inicial de **`500M`**.
   * Dale formato **`xfs`** y móntalo en **`/mnt/data`** de manera temporal o persistente.
   * **Extiende** el volumen lógico `lv_data` a un tamaño de **`1G`**, asegurando que el sistema de archivos subyacente se redimensione en caliente a la vez de manera exitosa.

4. **Creación de un Volumen LVM VDO (Virtual Data Optimizer)**:
   * Crea un volumen optimizado de tipo **VDO** llamado **`vdo_vol`** dentro de `vg_labs`.
   * El volumen VDO debe configurarse con:
     * Tamaño físico asignado al pool: **`4G`** (`-L 4G`)
     * Tamaño virtual presentado: **`8G`** (`-V 8G`)
   * Dale formato **`xfs`** y configúralo para montarse automáticamente en **`/mnt/vdo`**.

## Evaluación

Una vez configurado todo el LVM y sus montajes, valida tu solución ejecutando:

```bash
./verify.sh
```

Puedes ver pistas progresivas en `hints.md` y restablecer el entorno a su estado original con `./reset.sh`.
