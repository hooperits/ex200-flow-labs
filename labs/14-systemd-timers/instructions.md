# Reto Práctico: Systemd Timers para el Examen EX200

Este reto evaluará tu capacidad para crear y gestionar systemd timers y unidades en AlmaLinux 10 / RHEL 10.

**Nota RHEL 10**: systemd timers son idénticos.

## Objetivos del Reto

Navega al directorio `/labs/14-systemd-timers/` y realiza las siguientes tareas:

1. **Crear una Unidad Timer**:
   * Crea un archivo de servicio en `/etc/systemd/system/rhcsa-timer.service` con un oneshot que ejecuta un comando de prueba (ej. echo).
   * Crea el timer unit `/etc/systemd/system/rhcsa-timer.timer` con OnCalendar para cada minuto y Persistent=true.
   * Habilita e inicia el timer con `systemctl enable --now rhcsa-timer.timer`.
   * Lista timers con `systemctl list-timers | grep rhcsa`.

2. **Probar el Timer**:
   * Verifica estado con `systemctl is-active rhcsa-timer.timer`.
   * Muestra status detallado: `systemctl status rhcsa-timer.timer | head -5`.
   * Confirma en lista de timers: `systemctl list-timers | grep rhcsa`.

3. **Configurar Servicio Asociado**:
   * Asegura que el servicio asociado (rhcsa-timer.service) está correctamente referenciado por el timer.
   * Verifica que el servicio se activa vía timer: `systemctl status rhcsa-timer.service`.
   * Genera ejecución (puede requerir esperar o trigger manual si aplica).

4. **Validar y Documentar**:
   * Lista todos los timers activos: `systemctl list-timers --all`.
   * Documenta la ejecución en `challenge/timer.log` (incluye timestamp y comandos usados).
   * Deshabilita y limpia: `systemctl disable --now rhcsa-timer.timer`, remueve unidades y `systemctl daemon-reload`.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

