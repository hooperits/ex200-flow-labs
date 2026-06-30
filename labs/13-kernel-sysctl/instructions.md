# Reto Práctico: Parámetros del Kernel y sysctl para el Examen EX200

Este reto evaluará tu capacidad para inspeccionar y modificar parámetros del kernel con sysctl en AlmaLinux 9 / RHEL 9.

## Objetivos del Reto

Navega al directorio `/labs/13-kernel-sysctl/` y realiza las siguientes tareas:

1. **Inspeccionar Parámetros del Kernel**:
   * Ejecuta `sysctl -a | grep -E 'kernel|net.ipv4' | head -5` para listar parámetros clave.
   * Muestra hostname del kernel: `sysctl kernel.hostname`.
   * Inspecciona params de red: `sysctl net.ipv4.ip_forward`.
   * Verifica vía /proc: `cat /proc/sys/kernel/hostname`.

2. **Modificar Parámetros Temporalmente**:
   * Cambia hostname temporalmente: `sudo sysctl -w kernel.hostname=testhost`.
   * Verifica el cambio: `sysctl kernel.hostname` y `cat /proc/sys/kernel/hostname`.
   * Restaura: `sudo sysctl -w kernel.hostname=localhost`.
   * Nota que cambios con -w no persisten tras reinicio.

3. **Hacer Cambios Persistentes**:
   * Añade config persistente: `echo 'net.ipv4.ip_forward = 1' | sudo tee /etc/sysctl.d/99-test.conf`.
   * Aplica: `sudo sysctl -p /etc/sysctl.d/99-test.conf`.
   * Verifica: `sysctl net.ipv4.ip_forward`.
   * Limpia (en reset): remueve el archivo y restaura valor.

4. **Probar y Validar**:
   * Usa `sudo sysctl -w kernel.sysrq=1` para test.
   * Verifica en /proc: `cat /proc/sys/kernel/sysrq`.
   * Documenta en challenge/sysctl.conf (ej. los parámetros usados).
   * Verifica con `sysctl` y archivos en /etc/sysctl.d/.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

