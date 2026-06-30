# Reto Práctico: Logging y Journalctl Avanzado para el Examen EX200

Este reto evaluará tu capacidad para gestionar logs con journalctl, configurar rsyslog y persistencia de logs en AlmaLinux 9 / RHEL 9.

## Objetivos del Reto

Navega al directorio `/labs/11-logging/` y realiza las siguientes tareas:

1. **Inspeccionar Logs con journalctl**:
   * Muestra logs recientes del sistema.
   * Filtra logs por servicio (ej. sshd) y prioridad error.
   * Exporta logs a un archivo en challenge/.

2. **Configurar Persistencia de Logs**:
   * Crea /var/log/journal si no existe.
   * Configura journald para persistente (Storage=persistent).
   * Reinicia journald y verifica.

3. **Configurar rsyslog**:
   * Añade regla para forward logs a un archivo específico.
   * Reinicia rsyslog.
   * Verifica que los logs se escriben.

4. **Probar y Validar**:
   * Genera un log de prueba (logger).
   * Verifica que aparece en journal y rsyslog.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

