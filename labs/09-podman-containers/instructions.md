# Reto Práctico: Gestión de Contenedores con Podman (Módulo 09)

Este reto evalúa tu capacidad para desplegar contenedores sin privilegios de root (rootless), montar volúmenes persistentes con el flag de SELinux apropiado y automatizar el inicio de contenedores a través de servicios de `systemd` de usuario en Rocky/AlmaLinux 9.

## Objetivos del Reto

Realiza las siguientes tareas de configuración desde el usuario regular **`vagrant`** (no uses `sudo` para las tareas de Podman):

1. **Desplegar el Contenedor Rootless**:
   * Descarga la imagen oficial de servidor web de Red Hat: **`registry.access.redhat.com/ubi9/nginx-120`** (o en su defecto `nginx:alpine` si no hay internet).
   * Ejecuta un contenedor en segundo plano con las siguientes especificaciones:
     * Nombre del contenedor: **`web-server`**
     * Mapeo de puertos: Mapea el puerto del host **`8080`** al puerto del contenedor **`8080`** (o 80 en la imagen nginx standard, pero asegúrate de que responda por el puerto `8080` del host).
     * Volumen persistente: Crea el directorio local `/home/vagrant/html/` en el host. Móntalo en el contenedor en la ruta correspondiente al servidor web (para la imagen ubi9/nginx es `/usr/share/nginx/html`).
     * **IMPORTANTE (SELinux)**: Asegúrate de añadir la bandera de contexto de SELinux **`:Z`** al montar el volumen, de modo que SELinux permita el acceso del contenedor rootless al directorio del host.

2. **Configurar el Auto-arranque con systemd de Usuario**:
   * Crea el directorio de servicios de usuario: `~/.config/systemd/user/` (si no existe).
   * Genera el archivo de unidad de servicio de systemd para el contenedor `web-server` dentro de ese directorio. El comando de generación debe crear archivos que creen un contenedor nuevo en cada inicio (`--new`).
   * Habilita el servicio de usuario resultante para que se inicie de forma automática en el arranque.

3. **Configurar Persistencia de Sesión (Linger)**:
   * Configura el sistema (requiere privilegios de root con `loginctl`) para habilitar la persistencia de sesión del usuario **`vagrant`** (**`linger`**). Esto asegura que el servicio de systemd del usuario (y el contenedor) se inicie al arrancar la VM sin que el usuario tenga que haber iniciado sesión vía SSH.

## Evaluación

Una vez completadas todas las configuraciones, valida tu solución ejecutando:

```bash
./verify.sh
```

Puedes ver pistas progresivas en `hints.md` y restablecer el entorno a su estado original con `./reset.sh`.

