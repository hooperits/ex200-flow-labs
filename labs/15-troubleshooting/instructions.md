# Reto Práctico: Troubleshooting Escenarios para el Examen EX200

Este reto evaluará tu capacidad para diagnosticar y resolver problemas comunes en AlmaLinux 9 / RHEL 9.

## Objetivos del Reto

Navega al directorio `/labs/15-troubleshooting/` y realiza las siguientes tareas:

1. **Diagnosticar Servicio Fallido**:
   * Usa systemctl status y journalctl para un servicio fallido simulado.
   * Identifica causa.

2. **Resolver Permisos**:
   * Arregla permisos en un archivo o dir roto (simulado).

3. **Network Troubleshooting**:
   * Usa ip, ping, ss para diagnosticar.

4. **Validar**:
   * Documenta pasos en challenge/.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

