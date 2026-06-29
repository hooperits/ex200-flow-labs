# Pistas del Reto: 05-networking-services

## 1. Cambiar el Hostname
* Utiliza el comando `hostnamectl`:
  ```bash
  sudo hostnamectl set-hostname rhcsa-server
  ```

## 2. Configurar Red Estática
* Para encontrar el nombre exacto de la conexión del segundo dispositivo (por ejemplo, `Wired connection 1` o `eth1`):
  ```bash
  nmcli connection show
  ```
* Modifica la conexión para asignar la IP, gateway, DNS y cambiar el método a manual:
  ```bash
  sudo nmcli connection modify "NombreConexion" ipv4.addresses 192.168.56.20/24 ipv4.gateway 192.168.56.1 ipv4.dns 8.8.8.8 ipv4.method manual connection.autoconnect yes
  ```
* Aplica los cambios levantando la conexión:
  ```bash
  sudo nmcli connection up "NombreConexion"
  ```

## 3. Configuración NTP (Chrony)
* Edita `/etc/chrony.conf` y añade la siguiente línea:
  ```text
  server pool.ntp.org iburst
  ```
* Reinicia el daemon:
  ```bash
  sudo systemctl restart chronyd
  ```

## 4. Tarea Programada (Cron)
* Para editar el crontab del usuario `vagrant`:
  ```bash
  crontab -e
  ```
* Agrega la regla usando el formato `minuto hora dia_del_mes mes dia_de_la_semana comando`:
  ```text
  0 3 * * 1 echo "RHCSA Examen" >> /tmp/cron_test.txt
  ```
  *(Nota: en el formato cron, el día de la semana `1` corresponde al lunes).*
