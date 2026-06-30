# Reto Práctico: Systemd Timers para el Examen EX200

Este reto evaluará tu capacidad para crear y gestionar systemd timers y unidades en AlmaLinux 9 / RHEL 9.

## Objetivos del Reto

Navega al directorio `/labs/14-systemd-timers/` y realiza las siguientes tareas:

1. **Crear una Unidad Timer**:
   * Crea un timer en /etc/systemd/system/ para ejecutar un comando cada minuto.
   * Habilita e inicia el timer.

2. **Probar el Timer**:
   * Verifica que el timer está activo.
   * Usa systemctl list-timers.

3. **Configurar Servicio Asociado**:
   * Crea un servicio simple que el timer active.
   * Verifica ejecución.

4. **Validar**:
   * Lista timers activos.
   * Deshabilita después.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

