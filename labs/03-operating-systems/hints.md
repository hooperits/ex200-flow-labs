# Pistas del Reto: 03-operating-systems

## 1. Archivo de Servicio de systemd
* Crea el archivo `/etc/systemd/system/simple-web.service` con esta estructura:
  ```ini
  [Unit]
  Description=Simple Web Server
  After=network.target

  [Service]
  ExecStart=/usr/bin/python3 -m http.server 8080
  Restart=on-failure

  [Install]
  WantedBy=multi-user.target
  ```
* Recuerda recargar systemd después de crear el archivo: `systemctl daemon-reload`.
* Habilita e inicia el servicio en un solo paso: `systemctl enable --now simple-web.service`.

## 2. Target Predeterminado
* Para configurar el target de arranque por defecto, utiliza el comando `set-default`:
  ```bash
  systemctl set-default multi-user.target
  ```

## 3. Recuperación de Contraseña de root en GRUB
* Las palabras clave obligatorias son la secuencia estándar de RHEL 9:
  1. Parámetro de parada en el kernel: `rd.break`
  2. Remontar sysroot con permisos de escritura: `mount -o remount,rw /sysroot`
  3. Ingresar al entorno chroot: `chroot /sysroot`
  4. Comando de cambio de clave: `passwd`
  5. Crear archivo para relanzar SELinux: `touch /.autorelabel`
