# Reto Práctico: Gestión de Usuarios y Grupos (Módulo 04)

Este reto evalúa tu capacidad para gestionar cuentas de usuario, grupos de trabajo, aplicar permisos especiales (como SGID) y definir reglas de acceso fino usando ACLs en Rocky/AlmaLinux 9.

## Objetivos del Reto

Realiza las siguientes configuraciones de administración de usuarios en el sistema:

1. **Creación de Grupos y Usuarios**:
   * Crea un grupo de sistema llamado `sysadmin`.
   * Crea un usuario llamado `operator1`. Este usuario debe cumplir con:
     * Pertenecer al grupo `sysadmin` como grupo secundario.
     * Su shell por defecto debe ser `/sbin/nologin` (usuario de servicio sin acceso a consola).
   * Crea un usuario llamado `auditor1` (con configuraciones por defecto).

2. **Directorio Compartido y SGID**:
   * Crea el directorio `/srv/sysadmin_docs` (debes crearlo tú mismo).
   * Cambia el grupo propietario del directorio a `sysadmin`.
   * Configura los permisos del directorio para que:
     * El propietario (`root`) y el grupo (`sysadmin`) tengan permisos completos de lectura, escritura y ejecución.
     * El resto de usuarios ("others") no tengan ningún permiso (0).
     * Los nuevos archivos o carpetas creados dentro del directorio **hereden automáticamente el grupo propietario `sysadmin`** (SGID).

3. **Asignación de ACLs**:
   * Asigna un permiso de lectura y ejecución exclusivo para el usuario `auditor1` sobre el directorio `/srv/sysadmin_docs` y todo su contenido, asegurando que ningún otro usuario fuera del grupo `sysadmin` tenga acceso.

## Evaluación

Una vez completado el reto, valida tu solución ejecutando:

```bash
./verify.sh
```

Puedes ver pistas progresivas en `hints.md` y restablecer el entorno a su estado original con `./reset.sh`.
