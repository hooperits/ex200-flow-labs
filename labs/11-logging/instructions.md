# Reto Práctico: Logging y Journalctl Avanzado para el Examen EX200

Este reto evaluará tu capacidad para gestionar logs con journalctl, configurar rsyslog y persistencia de logs en AlmaLinux 10 / RHEL 10.

## Objetivos del Reto

Navega al directorio `/labs/11-logging/` y realiza las siguientes tareas:

1. **Inspeccionar Logs con journalctl**:
   * Muestra recientes: `journalctl -n 5 --no-pager`.
   * Filtra por servicio: `journalctl -u sshd -n 3 --no-pager`.
   * Filtra errores: `journalctl -p err -n 3 --no-pager`.
   * Logs desde boot: `journalctl -b -n 3 --no-pager`.
   * Exporta ejemplo a challenge/ si aplica.

2. **Configurar Persistencia de Logs**:
   * Crea dir: `sudo mkdir -p /var/log/journal`.
   * Configura persistente: `sudo sed -i 's/#Storage=.*/Storage=persistent/' /etc/systemd/journald.conf`.
   * Reinicia: `sudo systemctl restart systemd-journald`.
   * Verifica: `ls /var/log/journal/`.

3. **Configurar rsyslog**:
   * Añade regla: `echo 'local0.* /var/log/rhcsa-test.log' | sudo tee -a /etc/rsyslog.conf`.
   * Reinicia: `sudo systemctl restart rsyslog`.
   * Genera test: `logger -p local0.info 'RHCSA test log entry'`.
   * Verifica: `cat /var/log/rhcsa-test.log`.

4. **Probar y Validar**:
   * Genera más: `logger 'RHCSA final test'`.
   * Verifica journal: `journalctl -n 2 --no-pager | grep -i rhcsa || echo 'Check'`.
   * Confirma en rsyslog y journal.
   * Documenta usando challenge/test.log como evidencia.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

