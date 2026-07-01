# Reto Práctico: Gestión de Paquetes y Repositorios para el Examen EX200 (RHEL 10)

Este reto evaluará tu capacidad para configurar repositorios, gestionar paquetes con **DNF5**, instalar aplicaciones con **Flatpak** y crear repositorios locales en AlmaLinux 10 / RHEL 10.

## Objetivos del Reto

Navega al directorio `/labs/10-package-management/` y realiza las siguientes tareas en el subdirectorio `challenge/`:

1. **Configurar un Repositorio**:
   * Crea un archivo de repositorio en `/etc/yum.repos.d/local-test.repo`.
   * Configura el repositorio para apuntar a un servidor local (usa el export NFS simulado en /srv/nfs_export o un path local).
   * Habilita el repositorio y verifica con `dnf repolist`.

2. **Instalar y Gestionar Paquetes con DNF5**:
   * Instala el paquete `httpd` usando `dnf`.
   * Actualiza el paquete `bash` si hay actualizaciones disponibles.
   * Elimina el paquete `httpd` después de la instalación.

3. **Gestionar Aplicaciones con Flatpak**:
   * Instala `flatpak` si no está presente (`dnf install -y flatpak`).
   * Agrega el repositorio Flathub: `flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`
   * Instala una aplicación ligera con Flatpak (ej. `org.gnome.Calculator` si está disponible, o busca una CLI-friendly).
   * Lista las aplicaciones instaladas: `flatpak list`.

4. **Usar Módulos (AppStream)**:
   * Lista los módulos disponibles con `dnf module list`.
   * Habilita e instala un módulo disponible (ej. `nodejs` o `python` según lo que ofrezca el sistema).
   * Verifica el módulo habilitado.

5. **Crear un Repositorio Local**:
   * Crea el directorio `challenge/local-repo` si no existe.
   * Copia algunos RPMs disponibles (o usa paquetes del sistema) al directorio.
   * Ejecuta `createrepo challenge/local-repo`.
   * Crea un archivo .repo en `/etc/yum.repos.d/` que apunte a `file://` del directorio local.
   * Verifica que `dnf repolist` muestre el nuevo repo y que se pueda instalar un paquete desde él.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

