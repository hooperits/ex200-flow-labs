# Reto Práctico: Configuración de Red, NTP y Tareas Cron (Módulo 05)

Este reto evalúa tu capacidad para gestionar la identificación de host, configurar parámetros de red estáticos usando `nmcli`, configurar servidores de tiempo y programar automatizaciones usando `cron` en Rocky/AlmaLinux 9.

## Objetivos del Reto

Realiza las siguientes configuraciones dentro del entorno:

1. **Configurar el Hostname**:
   * Cambia el nombre de host del sistema de forma permanente a **`rhcsa-server`**.

2. **Configuración de Red Estática**:
   * Identifica la interfaz de red secundaria (generalmente es la segunda interfaz que aparece al ejecutar `nmcli device`, como `eth1` o `enp0s8`).
   * Configura una conexión de red llamada **`eth1`** (o el nombre correspondiente a esa interfaz) para que utilice los siguientes parámetros estáticos:
     * Dirección IP: `192.168.56.20/24`
     * Gateway (puerta de enlace): `192.168.56.1`
     * Servidor DNS: `8.8.8.8`
     * Método: Manual (estático).
   * Asegúrate de que la conexión se configure para activarse de forma automática y **levanta el enlace** para que los cambios surtan efecto de inmediato.

3. **Sincronización NTP (Chrony)**:
   * Edita la configuración del cliente NTP (`/etc/chrony.conf`) para agregar el servidor NTP **`pool.ntp.org`** con la opción `iburst` (si ya existe un servidor similar, asegúrate de que este servidor en particular esté presente y activo).
   * Reinicia el servicio `chronyd` para aplicar los cambios.

4. **Programación de Tareas con Cron**:
   * Crea una tarea programada para el usuario **`vagrant`**.
   * La tarea debe ejecutarse **todos los lunes exactamente a las 3:00 AM**.
   * El comando que debe ejecutar la tarea es: `echo "RHCSA Examen" >> /tmp/cron_test.txt`.

## Evaluación

Una vez completadas todas las configuraciones, valida tu solución ejecutando:

```bash
./verify.sh
```

Puedes ver pistas progresivas en `hints.md` y restablecer el entorno a su estado original con `./reset.sh`.

