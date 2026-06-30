# Esqueleto Video / Letras - 09-podman-containers
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/09-podman-containers/demo.sh
# Fecha: 2026-06-30
#
# Instrucciones:
# - Alinea con las letras en RHCSA-EX200-lyrics/.
# - Los tiempos son estimados (12s por comando aprox).
# - Ejecuta con `--video` para tiempos reales.
# - Comandos en inglés | Narrativa en español.

## Estructura sugerida del video/rap

### CORO / Intro
[00:00 - 00:00] - INTRO / GANCHO

[00:00 - 00:48] - ESTROFA 1: 1. Búsqueda y Descarga de Imágenes de Contenedor

- **Buscamos imágenes de nginx en los registros públicos configurados**
  ```
  podman search registry.access.redhat.com/ubi9/nginx-120 | head -n 4
  ```

- **Listamos las imágenes descargadas actualmente en el sistema local**
  ```
  podman images
  ```

- **Simulamos descargar una imagen ligera de prueba**
  ```
  echo 'podman pull registry.access.redhat.com/ubi9/nginx-120'
  ```

- **Mostramos los detalles y metadatos de una imagen**
  ```
  echo 'podman inspect registry.access.redhat.com/ubi9/nginx-120'
  ```

[00:48 - 01:36] - ESTROFA 2: 2. Creación, Ejecución y Listado de Contenedores

- **Listamos todos los contenedores activos**
  ```
  podman ps
  ```

- **Listamos todos los contenedores (incluyendo los detenidos)**
  ```
  podman ps -a
  ```

- **Simulamos crear y ejecutar un contenedor en segundo plano con puerto y volumen**
  ```
  echo 'podman run -d --name web-server -p 8080:8080 -v /home/vagrant/html:/var/www/html:Z nginx'
  ```

- **Simulamos ver los logs en tiempo real de un contenedor**
  ```
  echo 'podman logs web-server'
  ```

[01:36 - 02:24] - ESTROFA 3: 3. Ejecución Segura en Modo Rootless

- **Verificamos que el contenedor se ejecute con nuestro usuario sin usar sudo**
  ```
  whoami
  ```

- **Comprobamos el uso de puertos no privilegiados (mayores a 1024) para rootless**
  ```
  echo 'Mapeando puerto host 8080 hacia el contenedor'
  ```

- **Mostramos la información de namespaces de usuario activos en la VM**
  ```
  cat /proc/self/uid_map
  ```

- **Simulamos inspeccionar el estado de los procesos internos del contenedor**
  ```
  echo 'podman top web-server'
  ```

[02:24 - 03:12] - ESTROFA 4: 4. Automatización con systemd de Usuario y Linger

- **Simulamos generar el archivo de unidad systemd para el contenedor**
  ```
  echo 'podman generate systemd --new --files --name web-server'
  ```

- **Listamos las unidades de servicios del usuario actual**
  ```
  ls -l ~/.config/systemd/user/ 2>/dev/null || echo '(Directorio no creado aún)'
  ```

- **Simulamos habilitar el servicio de usuario de systemd**
  ```
  echo 'systemctl --user enable container-web-server.service'
  ```

- **Simulamos habilitar persistencia de sesión sin login (linger)**
  ```
  echo 'loginctl enable-linger vagrant'
  ```

[03:12 - 03:12] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~3 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap agresivo en español con un flujo chopper de velocidad máxima, rimas multisilábicas muy densas y complejas, dicción impecable incluso a alta velocidad y un estilo técnico, preciso y agresivo con gran complejidad rítmica y alto nivel técnico.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Búsqueda y Descarga de Imágenes de Contenedor
- Buscamos imágenes de nginx en los registros públicos configurados → podman search registry.access.redhat.com/ubi9/nginx-120 | head -n 4
- Listamos las imágenes descargadas actualmente en el sistema local → podman images
- Simulamos descargar una imagen ligera de prueba → echo 'podman pull registry.access.redhat.com/ubi9/nginx-120'
- Mostramos los detalles y metadatos de una imagen → echo 'podman inspect registry.access.redhat.com/ubi9/nginx-120'
ESTROFA: 2. Creación, Ejecución y Listado de Contenedores
- Listamos todos los contenedores activos → podman ps
- Listamos todos los contenedores (incluyendo los detenidos) → podman ps -a
- Simulamos crear y ejecutar un contenedor en segundo plano con puerto y volumen → echo 'podman run -d --name web-server -p 8080:8080 -v /home/vagrant/html:/var/www/html:Z nginx'
- Simulamos ver los logs en tiempo real de un contenedor → echo 'podman logs web-server'
ESTROFA: 3. Ejecución Segura en Modo Rootless
- Verificamos que el contenedor se ejecute con nuestro usuario sin usar sudo → whoami
- Comprobamos el uso de puertos no privilegiados (mayores a 1024) para rootless → echo 'Mapeando puerto host 8080 hacia el contenedor'
- Mostramos la información de namespaces de usuario activos en la VM → cat /proc/self/uid_map
- Simulamos inspeccionar el estado de los procesos internos del contenedor → echo 'podman top web-server'
ESTROFA: 4. Automatización con systemd de Usuario y Linger
- Simulamos generar el archivo de unidad systemd para el contenedor → echo 'podman generate systemd --new --files --name web-server'
- Listamos las unidades de servicios del usuario actual → ls -l ~/.config/systemd/user/ 2>/dev/null || echo '(Directorio no creado aún)'
- Simulamos habilitar el servicio de usuario de systemd → echo 'systemctl --user enable container-web-server.service'
- Simulamos habilitar persistencia de sesión sin login (linger) → echo 'loginctl enable-linger vagrant'

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
