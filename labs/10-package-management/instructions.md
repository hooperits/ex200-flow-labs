# Reto Práctico: Gestión de Paquetes y Repositorios para el Examen EX200

Este reto evaluará tu capacidad para configurar repositorios, gestionar paquetes con DNF, usar módulos y crear repositorios locales en AlmaLinux 9 / RHEL 9.

## Objetivos del Reto

Navega al directorio `/labs/10-package-management/` y realiza las siguientes tareas en el subdirectorio `challenge/`:

1. **Configurar un Repositorio DNF**:
   * Crea un archivo de repositorio en `/etc/yum.repos.d/local-test.repo`.
   * Configura el repositorio para apuntar a un servidor local (usa el export NFS simulado en /srv/nfs_export o un path local).
   * Habilita el repositorio y verifica con `dnf repolist`.

2. **Instalar y Gestionar Paquetes**:
   * Instala el paquete `httpd` usando `dnf`.
   * Actualiza el paquete `bash` si hay actualizaciones disponibles.
   * Elimina el paquete `httpd` después de la instalación (simula limpieza).

3. **Usar Módulos DNF (AppStream)**:
   * Lista los módulos disponibles con `dnf module list`.
   * Habilita e instala un módulo (ej. `nodejs:18` o `python39` según disponibilidad).
   * Verifica la instalación del módulo.

4. **Crear un Repositorio Local**:
   * Usa `createrepo` para crear un repositorio local en `challenge/local-repo` a partir de algunos RPMs descargados o copiados (usa paquetes existentes como `bash` o simula con archivos).
   * Configura un repo que apunte a ese directorio local.
   * Verifica que se pueda instalar un paquete desde él.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

