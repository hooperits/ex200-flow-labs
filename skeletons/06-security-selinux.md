# Esqueleto Video / Letras - 06-security-selinux
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/06-security-selinux/demo.sh
# Fecha: 2026-07-01
#
# Instrucciones:
# - Alinea con las letras en RHCSA-EX200-lyrics/.
# - Los tiempos son estimados (12s por comando aprox).
# - Ejecuta con `--video` para tiempos reales.
# - Comandos en inglés | Narrativa en español.

## Estructura sugerida del video/rap

### CORO / Intro
[00:00 - 00:00] - INTRO / GANCHO

[00:00 - 00:48] - ESTROFA 1: 1. Firewall (firewalld)

- **Listamos el estado de las reglas activas del firewall**
  ```
  sudo firewall-cmd --list-all | head -n 8
  ```

- **Obtenemos la zona por defecto asignada actualmente**
  ```
  sudo firewall-cmd --get-default-zone
  ```

- **Simulamos añadir el servicio http de forma permanente**
  ```
  echo 'firewall-cmd --permanent --add-service=http'
  ```

- **Simulamos aplicar los cambios en caliente usando reload**
  ```
  echo 'firewall-cmd --reload'
  ```

[00:48 - 01:36] - ESTROFA 2: 2. Modos de SELinux

- **Verificamos si SELinux está activo y en qué modo**
  ```
  getenforce
  ```

- **Mostramos los parámetros detallados de estado de SELinux**
  ```
  sestatus | head -n 6
  ```

- **Visualizamos los contextos de seguridad de archivos en /etc**
  ```
  ls -dZ /etc | head -n 4
  ```

- **Simulamos cambiar el modo activo temporalmente a Permissive**
  ```
  echo 'setenforce 0'
  ```

[01:36 - 02:24] - ESTROFA 3: 3. Contextos SELinux

- **Visualizamos los contextos del directorio raíz actual**
  ```
  ls -lZ / | head -n 6
  ```

- **Simulamos registrar una regla de contexto de seguridad para Apache**
  ```
  echo 'semanage fcontext -a -t httpd_sys_content_t \"/var/www/html(/.*)?\"'
  ```

- **Simulamos forzar la reescritura del contexto del archivo**
  ```
  echo 'restorecon -R -v /var/www/html'
  ```

- **Simulamos habilitar un puerto no estándar en SELinux**
  ```
  echo 'semanage port -a -t http_port_t -p tcp 82'
  ```

[02:24 - 03:12] - ESTROFA 4: 4. Booleanos SELinux

- **Buscamos algunos booleanos relacionados con servicios web**
  ```
  getsebool -a | grep httpd | head -n 4
  ```

- **Mostramos el estado actual de un booleano en particular**
  ```
  getsebool httpd_enable_homedirs
  ```

- **Simulamos cambiar el valor de un booleano de forma permanente con -P**
  ```
  echo 'setsebool -P httpd_enable_homedirs on'
  ```

- **Comprobamos el comando de listado detallado de booleanos**
  ```
  semanage boolean -l | grep httpd_enable_homedirs | head -n 1
  ```

[03:12 - 03:12] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~3 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Firewall (firewalld)
- Listamos el estado de las reglas activas del firewall → sudo firewall-cmd --list-all | head -n 8
- Obtenemos la zona por defecto asignada actualmente → sudo firewall-cmd --get-default-zone
- Simulamos añadir el servicio http de forma permanente → echo 'firewall-cmd --permanent --add-service=http'
- Simulamos aplicar los cambios en caliente usando reload → echo 'firewall-cmd --reload'
ESTROFA: 2. Modos de SELinux
- Verificamos si SELinux está activo y en qué modo → getenforce
- Mostramos los parámetros detallados de estado de SELinux → sestatus | head -n 6
- Visualizamos los contextos de seguridad de archivos en /etc → ls -dZ /etc | head -n 4
- Simulamos cambiar el modo activo temporalmente a Permissive → echo 'setenforce 0'
ESTROFA: 3. Contextos SELinux
- Visualizamos los contextos del directorio raíz actual → ls -lZ / | head -n 6
- Simulamos registrar una regla de contexto de seguridad para Apache → echo 'semanage fcontext -a -t httpd_sys_content_t \"/var/www/html(/.*)?\"'
- Simulamos forzar la reescritura del contexto del archivo → echo 'restorecon -R -v /var/www/html'
- Simulamos habilitar un puerto no estándar en SELinux → echo 'semanage port -a -t http_port_t -p tcp 82'
ESTROFA: 4. Booleanos SELinux
- Buscamos algunos booleanos relacionados con servicios web → getsebool -a | grep httpd | head -n 4
- Mostramos el estado actual de un booleano en particular → getsebool httpd_enable_homedirs
- Simulamos cambiar el valor de un booleano de forma permanente con -P → echo 'setsebool -P httpd_enable_homedirs on'
- Comprobamos el comando de listado detallado de booleanos → semanage boolean -l | grep httpd_enable_homedirs | head -n 1

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
