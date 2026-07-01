# Esqueleto Video / Letras - 05-networking-services
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/05-networking-services/demo.sh
# Fecha: 2026-07-01
#
# Instrucciones:
# - Alinea con las letras en RHCSA-EX200-lyrics/.
# - Los tiempos son estimados (12s por comando aprox).
# - Ejecuta con `--video` para tiempos reales.
# - Comandos en inglés | Narrativa en español.

## Estructura sugerida del video/rap

### CORO / Intro
[00:00 - 00:00] - INTRO / GANCHO

[00:00 - 00:48] - ESTROFA 1: 1. Hostname

- **Visualizamos la información actual del nombre del host**
  ```
  hostnamectl status
  ```

- **Simulamos configurar el hostname permanente del servidor**
  ```
  echo 'hostnamectl set-hostname server-test'
  ```

- **Leemos el archivo /etc/hosts para la resolución local**
  ```
  head -n 5 /etc/hosts
  ```

- **Mostramos la IP asociada al hostname actual**
  ```
  hostname -I | awk '{print \$1}'
  ```

[00:48 - 01:36] - ESTROFA 2: 2. Red con nmcli

- **Listamos todos los dispositivos de red disponibles**
  ```
  nmcli device
  ```

- **Listamos las conexiones de red configuradas**
  ```
  nmcli connection show
  ```

- **Simulamos modificar una conexión para asignar IP estática**
  ```
  echo 'nmcli connection modify eth1 ipv4.addresses 192.168.56.20/24'
  ```

- **Simulamos reactivar la conexión modificada**
  ```
  echo 'nmcli connection up eth1'
  ```

[01:36 - 02:24] - ESTROFA 3: 3. NTP con chrony

- **Comprobamos el estado del servicio chronyd**
  ```
  systemctl status chronyd | head -n 4
  ```

- **Verificamos los servidores de tiempo NTP conectados usando chronyc**
  ```
  chronyc sources
  ```

- **Mostramos los parámetros de sincronización del reloj del sistema**
  ```
  chronyc tracking
  ```

- **Buscamos los servidores NTP definidos en el archivo de configuración**
  ```
  grep '^server' /etc/chrony.conf || grep '^pool' /etc/chrony.conf
  ```

[02:24 - 03:12] - ESTROFA 4: 4. Tareas con Cron

- **Listamos las tareas cron programadas para el usuario actual**
  ```
  crontab -l 2>/dev/null || echo '(No hay tareas programadas para vagrant)'
  ```

- **Listamos los archivos de tareas cron del sistema en /etc/cron.d/**
  ```
  ls -l /etc/cron.d/ | head -n 5
  ```

- **Mostramos el contenido del archivo crontab del sistema principal**
  ```
  head -n 12 /etc/crontab
  ```

- **Simulamos programar una tarea cron usando crontab -e**
  ```
  echo '0 2 * * * /usr/local/bin/backup.sh'
  ```

[03:12 - 03:12] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~3 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Hostname
- Visualizamos la información actual del nombre del host → hostnamectl status
- Simulamos configurar el hostname permanente del servidor → echo 'hostnamectl set-hostname server-test'
- Leemos el archivo /etc/hosts para la resolución local → head -n 5 /etc/hosts
- Mostramos la IP asociada al hostname actual → hostname -I | awk '{print \$1}'
ESTROFA: 2. Red con nmcli
- Listamos todos los dispositivos de red disponibles → nmcli device
- Listamos las conexiones de red configuradas → nmcli connection show
- Simulamos modificar una conexión para asignar IP estática → echo 'nmcli connection modify eth1 ipv4.addresses 192.168.56.20/24'
- Simulamos reactivar la conexión modificada → echo 'nmcli connection up eth1'
ESTROFA: 3. NTP con chrony
- Comprobamos el estado del servicio chronyd → systemctl status chronyd | head -n 4
- Verificamos los servidores de tiempo NTP conectados usando chronyc → chronyc sources
- Mostramos los parámetros de sincronización del reloj del sistema → chronyc tracking
- Buscamos los servidores NTP definidos en el archivo de configuración → grep '^server' /etc/chrony.conf || grep '^pool' /etc/chrony.conf
ESTROFA: 4. Tareas con Cron
- Listamos las tareas cron programadas para el usuario actual → crontab -l 2>/dev/null || echo '(No hay tareas programadas para vagrant)'
- Listamos los archivos de tareas cron del sistema en /etc/cron.d/ → ls -l /etc/cron.d/ | head -n 5
- Mostramos el contenido del archivo crontab del sistema principal → head -n 12 /etc/crontab
- Simulamos programar una tarea cron usando crontab -e → echo '0 2 * * * /usr/local/bin/backup.sh'

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
