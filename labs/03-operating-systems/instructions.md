# Reto Práctico: Operación del Sistema (Módulo 03)

Este reto evalúa tu capacidad para gestionar servicios de `systemd`, configurar niveles de arranque (`targets`) y documentar el proceso de recuperación de contraseña de root en RHEL 10.

## Objetivos del Reto

Resuelve los siguientes retos dentro del entorno virtual:

1. **Configurar un Servicio Personalizado de systemd**:
   * Debes crear un archivo de unidad de servicio llamado `simple-web.service` en `/etc/systemd/system/`.
   * El servicio debe ejecutar el servidor web integrado de Python en el puerto `8080` (comando: `/usr/bin/python3 -m http.server 8080`).
   * El servicio debe configurarse para que se inicie automáticamente en el arranque (`enabled`).
   * El servicio debe estar actualmente activo y corriendo (`running`).

2. **Cambiar el Target de Arranque Predeterminado**:
   * Cambia el target por defecto del sistema a modo consola sin interfaz gráfica (`multi-user.target`).
   * Asegúrate de que el cambio sea persistente para los próximos reinicios del sistema.

3. **Documentar el Proceso de Recuperación de Contraseña de root**:
   * Crea un archivo llamado `root_recovery.txt` en el subdirectorio `challenge/`.
   * Escribe la secuencia exacta de comandos y pasos necesarios para recuperar el acceso de root interrumpiendo el cargador de arranque GRUB.
   * Debes incluir las palabras clave y comandos exactos: `rd.break`, `remount,rw`, `/sysroot`, `chroot`, `passwd`, y `/.autorelabel`.

## Evaluación

Una vez completadas todas las configuraciones, valida tu solución ejecutando:

```bash
./verify.sh
```

Puedes ver pistas progresivas en `hints.md` y restablecer las configuraciones a su estado inicial con `./reset.sh`.

