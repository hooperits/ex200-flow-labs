# Esqueleto Video / Letras - 11-logging
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/11-logging/demo.sh
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

[00:00 - 00:48] - ESTROFA 1: 1. Inspeccionar Logs con journalctl

- **Mostramos logs recientes**
  ```
  journalctl -n 5 --no-pager
  ```

- **Filtramos por servicio sshd**
  ```
  journalctl -u sshd -n 3 --no-pager
  ```

- **Filtramos errores**
  ```
  journalctl -p err -n 3 --no-pager
  ```

- **Logs desde boot actual**
  ```
  journalctl -b -n 3 --no-pager
  ```

[00:48 - 01:36] - ESTROFA 2: 2. Configurar Persistencia de Logs

- **Creamos dir journal si necesario**
  ```
  sudo mkdir -p /var/log/journal
  ```

- **Configuramos journald persistente**
  ```
  sudo sed -i 's/#Storage=.*/Storage=persistent/' /etc/systemd/journald.conf || echo 'Edit manual si necesario'
  ```

- **Reiniciamos journald**
  ```
  sudo systemctl restart systemd-journald
  ```

- **Verificamos persistencia**
  ```
  ls /var/log/journal/ || echo 'Verificación'
  ```

[01:36 - 02:24] - ESTROFA 3: 3. Configurar rsyslog

- **Añadimos regla rsyslog para test**
  ```
  echo 'local0.* /var/log/rhcsa-test.log' | sudo tee -a /etc/rsyslog.conf
  ```

- **Reiniciamos rsyslog**
  ```
  sudo systemctl restart rsyslog
  ```

- **Generamos log de prueba**
  ```
  logger -p local0.info 'RHCSA test log entry'
  ```

- **Verificamos en rsyslog**
  ```
  cat /var/log/rhcsa-test.log || echo 'Verificación'
  ```

[02:24 - 02:54] - ESTROFA 4: 4. Probar Logs

- **Generamos más logs**
  ```
  logger 'RHCSA final test'
  ```

- **Verificamos en journal**
  ```
  journalctl -n 2 --no-pager | grep -i rhcsa || echo 'Check'
  ```

[02:54 - 02:54] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~2 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Inspeccionar Logs con journalctl
- Mostramos logs recientes → journalctl -n 5 --no-pager
- Filtramos por servicio sshd → journalctl -u sshd -n 3 --no-pager
- Filtramos errores → journalctl -p err -n 3 --no-pager
- Logs desde boot actual → journalctl -b -n 3 --no-pager
ESTROFA: 2. Configurar Persistencia de Logs
- Creamos dir journal si necesario → sudo mkdir -p /var/log/journal
- Configuramos journald persistente → sudo sed -i 's/#Storage=.*/Storage=persistent/' /etc/systemd/journald.conf || echo 'Edit manual si necesario'
- Reiniciamos journald → sudo systemctl restart systemd-journald
- Verificamos persistencia → ls /var/log/journal/ || echo 'Verificación'
ESTROFA: 3. Configurar rsyslog
- Añadimos regla rsyslog para test → echo 'local0.* /var/log/rhcsa-test.log' | sudo tee -a /etc/rsyslog.conf
- Reiniciamos rsyslog → sudo systemctl restart rsyslog
- Generamos log de prueba → logger -p local0.info 'RHCSA test log entry'
- Verificamos en rsyslog → cat /var/log/rhcsa-test.log || echo 'Verificación'
ESTROFA: 4. Probar Logs
- Generamos más logs → logger 'RHCSA final test'
- Verificamos en journal → journalctl -n 2 --no-pager | grep -i rhcsa || echo 'Check'

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
