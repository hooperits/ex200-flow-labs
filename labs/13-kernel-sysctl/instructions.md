# Reto Práctico: Parámetros del Kernel y sysctl para el Examen EX200

Este reto evaluará tu capacidad para inspeccionar y modificar parámetros del kernel con sysctl en AlmaLinux 9 / RHEL 9.

## Objetivos del Reto

Navega al directorio `/labs/13-kernel-sysctl/` y realiza las siguientes tareas:

1. **Inspeccionar Parámetros del Kernel**:
   * Lista parámetros con sysctl -a.
   * Busca parámetros relacionados con networking (net.*).
   * Muestra valor actual de kernel.hostname.

2. **Modificar Parámetros Temporalmente**:
   * Cambia kernel.hostname temporalmente con sysctl.
   * Verifica el cambio.
   * Nota que no persiste (reinicio lo revierte).

3. **Hacer Cambios Persistentes**:
   * Añade o edita /etc/sysctl.conf o /etc/sysctl.d/ con un parámetro (ej. net.ipv4.ip_forward=1).
   * Aplica con sysctl -p.
   * Verifica persistencia (simulada, ya que no reinicias).

4. **Probar y Validar**:
   * Usa sysctl -w para cambios.
   * Verifica con cat /proc/sys/...

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

