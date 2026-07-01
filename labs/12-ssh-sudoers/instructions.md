# Reto Práctico: SSH, Claves y Sudoers para el Examen EX200

Este reto evaluará tu capacidad para configurar SSH con claves, gestionar usuarios con sudoers y controlar acceso en AlmaLinux 10 / RHEL 10.

**Nota RHEL 10**: sshd y sudoers funcionan igual. Las políticas de crypto pueden ser más estrictas.

## Objetivos del Reto

Navega al directorio `/labs/12-ssh-sudoers/` y realiza las siguientes tareas:

1. **Configurar Autenticación por Claves SSH**:
   * Genera par de claves: `ssh-keygen -t rsa -f /tmp/id_rsa_test -N '' -q`.
   * Crea dir y perms: `mkdir -p ~/.ssh && chmod 700 ~/.ssh`.
   * Copia pub: `cat /tmp/id_rsa_test.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys`.
   * Verifica: `ls -l ~/.ssh/authorized_keys`.

2. **Configurar sudoers**:
   * Crea sudoers.d para grupo: `echo '%wheel ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/wheel-nopasswd`.
   * Verifica sintaxis: `sudo visudo -c -f /etc/sudoers.d/wheel-nopasswd`.
   * Prueba: `sudo -l | head -3`.

3. **Restringir Acceso SSH**:
   * Backup: `sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak`.
   * Edita para deshabilitar root: `sudo sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config`.
   * Reinicia: `sudo systemctl restart sshd || echo 'Verifica'`.
   * Verifica: `grep PermitRootLogin /etc/ssh/sshd_config`.

4. **Probar y Validar**:
   * Verifica id: `id vagrant`.
   * Prueba sudo sim: `sudo -u vagrant echo 'test' || true`.
   * Documenta evidencia usando challenge/authorized_keys y challenge/sudoers como referencia.
   * Verifica sintaxis general: `sudo visudo -c`.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

