# Esqueleto Video / Letras - 10-package-management
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/10-package-management/demo.sh
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

[00:00 - 01:00] - ESTROFA 1: 1. Configurar un Repositorio DNF

- **Instalamos createrepo si es necesario**
  ```
  dnf install -y createrepo &>/dev/null || true
  ```

- **Creamos un directorio para el repo local**
  ```
  mkdir -p /tmp/local-repo && cp /var/cache/dnf/*/packages/bash*.rpm /tmp/local-repo/ 2>/dev/null || echo 'Usando paquetes de ejemplo'
  ```

- **Creamos el repositorio local**
  ```
  createrepo /tmp/local-repo
  ```

- **Creamos el archivo .repo**
  ```
  echo '[local-test]
  ```

- **Verificamos los repositorios**
  ```
  dnf repolist --enabled | head -5
  ```

[01:00 - 02:00] - ESTROFA 2: 2. Instalar y Gestionar Paquetes con DNF

- **Buscamos un paquete**
  ```
  dnf search httpd | head -3
  ```

- **Instalamos httpd (si no está)**
  ```
  dnf install -y httpd &>/dev/null || true
  ```

- **Verificamos instalación**
  ```
  rpm -q httpd
  ```

- **Actualizamos información de paquetes**
  ```
  dnf check-update | head -3 || true
  ```

- **Limpiamos cache de dnf**
  ```
  dnf clean all
  ```

[02:00 - 02:48] - ESTROFA 3: 3. Usar Módulos DNF

- **Listamos módulos disponibles**
  ```
  dnf module list | head -5
  ```

- **Habilitamos un módulo de ejemplo (si disponible)**
  ```
  dnf module enable -y nodejs:18 2>/dev/null || echo 'Módulo de ejemplo (puede variar por versión)'
  ```

- **Instalamos desde módulo**
  ```
  dnf module install -y nodejs:18/minimal 2>/dev/null || echo 'Simulando instalación de módulo'
  ```

- **Verificamos módulo activo**
  ```
  dnf module list --enabled | grep nodejs || echo 'Verificación de módulo'
  ```

[02:48 - 03:36] - ESTROFA 4: 4. Crear un Repositorio Local

- **Preparamos directorio para repo local**
  ```
  mkdir -p /tmp/myrepo && cp /var/cache/dnf/*/packages/coreutils*.rpm /tmp/myrepo/ 2>/dev/null || touch /tmp/myrepo/dummy.rpm
  ```

- **Creamos metadatos del repo**
  ```
  createrepo /tmp/myrepo
  ```

- **Configuramos repo que apunta al local**
  ```
  echo '[my-local]
  ```

- **Verificamos el nuevo repo**
  ```
  dnf repolist | grep my-local || true
  ```

[03:36 - 03:36] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~3 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Configurar un Repositorio DNF
- Instalamos createrepo si es necesario → dnf install -y createrepo &>/dev/null || true
- Creamos un directorio para el repo local → mkdir -p /tmp/local-repo && cp /var/cache/dnf/*/packages/bash*.rpm /tmp/local-repo/ 2>/dev/null || echo 'Usando paquetes de ejemplo'
- Creamos el repositorio local → createrepo /tmp/local-repo
- Creamos el archivo .repo → echo '[local-test]
- Verificamos los repositorios → dnf repolist --enabled | head -5
ESTROFA: 2. Instalar y Gestionar Paquetes con DNF
- Buscamos un paquete → dnf search httpd | head -3
- Instalamos httpd (si no está) → dnf install -y httpd &>/dev/null || true
- Verificamos instalación → rpm -q httpd
- Actualizamos información de paquetes → dnf check-update | head -3 || true
- Limpiamos cache de dnf → dnf clean all
ESTROFA: 3. Usar Módulos DNF
- Listamos módulos disponibles → dnf module list | head -5
- Habilitamos un módulo de ejemplo (si disponible) → dnf module enable -y nodejs:18 2>/dev/null || echo 'Módulo de ejemplo (puede variar por versión)'
- Instalamos desde módulo → dnf module install -y nodejs:18/minimal 2>/dev/null || echo 'Simulando instalación de módulo'
- Verificamos módulo activo → dnf module list --enabled | grep nodejs || echo 'Verificación de módulo'
ESTROFA: 4. Crear un Repositorio Local
- Preparamos directorio para repo local → mkdir -p /tmp/myrepo && cp /var/cache/dnf/*/packages/coreutils*.rpm /tmp/myrepo/ 2>/dev/null || touch /tmp/myrepo/dummy.rpm
- Creamos metadatos del repo → createrepo /tmp/myrepo
- Configuramos repo que apunta al local → echo '[my-local]
- Verificamos el nuevo repo → dnf repolist | grep my-local || true

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
