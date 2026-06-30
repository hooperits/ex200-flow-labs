# Reto Práctico: SSH, Claves y Sudoers para el Examen EX200

Este reto evaluará tu capacidad para configurar SSH con claves, gestionar usuarios con sudoers y controlar acceso en AlmaLinux 9 / RHEL 9.

## Objetivos del Reto

Navega al directorio `/labs/12-ssh-sudoers/` y realiza las siguientes tareas:

1. **Configurar Autenticación por Claves SSH**:
   * Genera un par de claves SSH para el usuario vagrant.
   * Copia la clave pública a authorized_keys.
   * Verifica conexión sin password (usa ssh-copy-id o manual).

2. **Configurar sudoers**:
   * Crea un archivo en /etc/sudoers.d/ para dar permisos a un grupo.
   * Añade una regla para que un usuario ejecute comandos sin password.
   * Verifica con sudo -l.

3. **Restringir Acceso SSH**:
   * Edita /etc/ssh/sshd_config para permitir solo usuarios específicos o deshabilitar root login.
   * Reinicia sshd.
   * Verifica configuración.

4. **Probar y Validar**:
   * Prueba acceso SSH.
   * Prueba sudo.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

