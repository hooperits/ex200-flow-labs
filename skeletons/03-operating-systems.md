# Esqueleto Video / Letras - 03-operating-systems
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/03-operating-systems/demo.sh
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

[00:00 - 00:48] - ESTROFA 1: 1. Servicios con systemctl

- **Comprobamos el estado del servicio sshd**
  ```
  systemctl status sshd | head -n 5
  ```

- **Verificamos si un servicio está habilitado para el arranque**
  ```
  systemctl is-enabled sshd
  ```

- **Verificamos si un servicio está actualmente activo**
  ```
  systemctl is-active sshd
  ```

- **Listamos todos los servicios cargados en el sistema**
  ```
  systemctl list-units --type=service --state=running | head -n 6
  ```

[00:48 - 01:36] - ESTROFA 2: 2. Targets de Arranque

- **Obtenemos el target predeterminado del sistema**
  ```
  systemctl get-default
  ```

- **Listamos los targets disponibles actualmente**
  ```
  systemctl list-units --type=target | head -n 6
  ```

- **Simulamos cómo cambiar el target a modo consola (multi-user.target)**
  ```
  echo 'systemctl set-default multi-user.target'
  ```

- **Simulamos cómo cambiar el target a modo gráfico (graphical.target)**
  ```
  echo 'systemctl set-default graphical.target'
  ```

[01:36 - 03:12] - ESTROFA 3: 3. Procesos y Logs (journalctl)

- **Listamos procesos ordenados por consumo de recursos**
  ```
  ps aux --sort=-%cpu | head -n 5
  ```

- **Buscamos un proceso específico por su nombre usando pgrep**
  ```
  pgrep -l systemd | head -n 4
  ```

- **Mostramos la prioridad 'nice' de los procesos en ejecución**
  ```
  ps -el | head -n 5
  ```

- **Simulamos cómo cambiar la prioridad de un proceso con renice**
  ```
  echo 'renice -n 5 -p 1234'
  ```

- **Mostramos las últimas 5 líneas del log del sistema**
  ```
  sudo journalctl -n 5 --no-pager
  ```

- **Filtramos los logs de un servicio específico como sshd**
  ```
  sudo journalctl -u sshd -n 4 --no-pager
  ```

- **Filtramos los logs mostrando únicamente errores importantes con '-p err'**
  ```
  sudo journalctl -p err -n 4 --no-pager
  ```

- **Mostramos los logs generados desde el arranque actual usando '-b'**
  ```
  sudo journalctl -b -n 4 --no-pager
  ```

[03:12 - 04:48] - ESTROFA 4: 4. Recuperación root (rd.break)

- **Interrumpimos el arranque presionando e en el menú de GRUB**
  ```
  echo 'Presiona e para editar la entrada'
  ```

- **Agregamos rd.break al final de la línea que empieza con linux**
  ```
  echo 'Añade rd.break'
  ```

- **Boot con Ctrl+X o F10**
  ```
  echo 'Continúa el arranque'
  ```

- **Remontamos /sysroot en modo escritura**
  ```
  mount -o remount,rw /sysroot
  ```

- **Entramos al sistema con chroot**
  ```
  chroot /sysroot
  ```

- **Cambiamos la contraseña de root**
  ```
  passwd
  ```

- **Creamos el archivo para que SELinux relabel en el próximo boot**
  ```
  touch /.autorelabel
  ```

- **Salimos del chroot y del entorno de recuperación**
  ```
  exit ; exit
  ```

[04:48 - 04:48] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~4 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Servicios con systemctl
- Comprobamos el estado del servicio sshd → systemctl status sshd | head -n 5
- Verificamos si un servicio está habilitado para el arranque → systemctl is-enabled sshd
- Verificamos si un servicio está actualmente activo → systemctl is-active sshd
- Listamos todos los servicios cargados en el sistema → systemctl list-units --type=service --state=running | head -n 6
ESTROFA: 2. Targets de Arranque
- Obtenemos el target predeterminado del sistema → systemctl get-default
- Listamos los targets disponibles actualmente → systemctl list-units --type=target | head -n 6
- Simulamos cómo cambiar el target a modo consola (multi-user.target) → echo 'systemctl set-default multi-user.target'
- Simulamos cómo cambiar el target a modo gráfico (graphical.target) → echo 'systemctl set-default graphical.target'
ESTROFA: 3. Procesos y Logs (journalctl)
- Listamos procesos ordenados por consumo de recursos → ps aux --sort=-%cpu | head -n 5
- Buscamos un proceso específico por su nombre usando pgrep → pgrep -l systemd | head -n 4
- Mostramos la prioridad 'nice' de los procesos en ejecución → ps -el | head -n 5
- Simulamos cómo cambiar la prioridad de un proceso con renice → echo 'renice -n 5 -p 1234'
- Mostramos las últimas 5 líneas del log del sistema → sudo journalctl -n 5 --no-pager
- Filtramos los logs de un servicio específico como sshd → sudo journalctl -u sshd -n 4 --no-pager
- Filtramos los logs mostrando únicamente errores importantes con '-p err' → sudo journalctl -p err -n 4 --no-pager
- Mostramos los logs generados desde el arranque actual usando '-b' → sudo journalctl -b -n 4 --no-pager
ESTROFA: 4. Recuperación root (rd.break)
- Interrumpimos el arranque presionando e en el menú de GRUB → echo 'Presiona e para editar la entrada'
- Agregamos rd.break al final de la línea que empieza con linux → echo 'Añade rd.break'
- Boot con Ctrl+X o F10 → echo 'Continúa el arranque'
- Remontamos /sysroot en modo escritura → mount -o remount,rw /sysroot
- Entramos al sistema con chroot → chroot /sysroot
- Cambiamos la contraseña de root → passwd
- Creamos el archivo para que SELinux relabel en el próximo boot → touch /.autorelabel
- Salimos del chroot y del entorno de recuperación → exit ; exit

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
