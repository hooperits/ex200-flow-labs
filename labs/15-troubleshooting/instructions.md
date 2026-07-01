# Reto Práctico: Troubleshooting Escenarios para el Examen EX200

Este reto evaluará tu capacidad para diagnosticar y resolver problemas comunes en AlmaLinux 10 / RHEL 10.

## Objetivos del Reto

Navega al directorio `/labs/15-troubleshooting/` y realiza las siguientes tareas en el subdirectorio `challenge/` donde corresponda:

1. **Diagnosticar Servicio Fallido**:
   * Ejecuta `systemctl status sshd` para ver el estado actual.
   * Usa `journalctl -u sshd -n 20 --no-pager` para inspeccionar logs recientes del servicio.
   * Filtra con `journalctl -p err -n 10 --no-pager` para errores.
   * Identifica la causa del problema (simulado vía datos en challenge/ si aplica) y anota en `challenge/troubleshoot.log`.

2. **Resolver Permisos**:
   * Crea o identifica un archivo con permisos rotos (ej. `touch /tmp/broken_perm.txt && chmod 000 /tmp/broken_perm.txt`).
   * Diagnostica con `ls -l /tmp/broken_perm.txt` y `stat`.
   * Arregla los permisos (ej. `chmod 644 /tmp/broken_perm.txt`).
   * Verifica el fix y documenta el comando usado en el log de diagnóstico.

3. **Network Troubleshooting**:
   * Usa `ip addr show` para inspeccionar interfaces.
   * Prueba conectividad local con `ping -c 1 127.0.0.1`.
   * Lista puertos y conexiones: `ss -tuln | head -10` y `ss -tuln | grep LISTEN`.
   * Identifica problemas de red (ej. servicios escuchando) y registra hallazgos.

4. **Probar, Validar y Documentar**:
   * Genera un log de prueba: `logger 'RHCSA troubleshooting test'`.
   * Verifica con `journalctl -n 5 --no-pager | grep -i rhcsa || true`.
   * Crea un resumen completo de diagnóstico en `challenge/troubleshoot.log` (incluye comandos usados y conclusiones).
   * Ejecuta `./verify.sh` para confirmar.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

