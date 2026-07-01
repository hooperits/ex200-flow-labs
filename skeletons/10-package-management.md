# Esqueleto Video / Letras - 10-package-management
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/10-package-management/demo.sh
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

[00:00 - 00:30] - ESTROFA 1: RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 1. Configurar un Repositorio

- **Creamos el archivo de repo local**
  ```
  mkdir -p /tmp/local-repo && echo '[local-test]
  ```

- **Verificamos repositorios**
  ```
  dnf repolist --enabled | head -3
  ```

[00:30 - 01:30] - ESTROFA 2: RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 2. Paquetes con DNF5

- **Buscamos un paquete**
  ```
  dnf search httpd | head -2
  ```

- **Instalamos httpd**
  ```
  dnf install -y httpd &>/dev/null || true
  ```

- **Verificamos**
  ```
  rpm -q httpd
  ```

- **Actualizamos bash**
  ```
  dnf update -y bash &>/dev/null || true
  ```

- **Removemos httpd**
  ```
  dnf remove -y httpd &>/dev/null || true
  ```

[01:30 - 02:18] - ESTROFA 3: RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 3. Flatpak

- **Instalamos flatpak**
  ```
  dnf install -y flatpak &>/dev/null || true
  ```

- **Agregamos Flathub**
  ```
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>/dev/null || true
  ```

- **Instalamos app de ejemplo (puede variar)**
  ```
  flatpak install -y flathub org.gnome.Calculator 2>/dev/null || echo 'Flatpak de ejemplo (puede necesitar red)'
  ```

- **Listamos apps Flatpak**
  ```
  flatpak list | head -3 || true
  ```

[02:18 - 02:54] - ESTROFA 4: RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 4. Módulos AppStream

- **Listamos módulos**
  ```
  dnf module list | head -4
  ```

- **Habilitamos módulo de ejemplo**
  ```
  dnf module enable -y nodejs:18 2>/dev/null || echo 'Módulo ejemplo (puede variar)'
  ```

- **Verificamos módulo**
  ```
  dnf module list --enabled | head -2 || true
  ```

[02:54 - 03:42] - ESTROFA 5: RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 5. Repositorio Local

- **Preparamos directorio local**
  ```
  mkdir -p challenge/local-repo && cp /var/cache/dnf/*/*/packages/bash*.rpm challenge/local-repo/ 2>/dev/null || touch challenge/local-repo/dummy.rpm
  ```

- **Creamos metadatos**
  ```
  createrepo challenge/local-repo
  ```

- **Configuramos .repo local**
  ```
  echo '[my-local]
  ```

- **Verificamos nuevo repo**
  ```
  dnf repolist | grep my-local || true
  ```

[03:42 - 03:42] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~3 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 1. Configurar un Repositorio
- Creamos el archivo de repo local → mkdir -p /tmp/local-repo && echo '[local-test]
- Verificamos repositorios → dnf repolist --enabled | head -3
ESTROFA: RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 2. Paquetes con DNF5
- Buscamos un paquete → dnf search httpd | head -2
- Instalamos httpd → dnf install -y httpd &>/dev/null || true
- Verificamos → rpm -q httpd
- Actualizamos bash → dnf update -y bash &>/dev/null || true
- Removemos httpd → dnf remove -y httpd &>/dev/null || true
ESTROFA: RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 3. Flatpak
- Instalamos flatpak → dnf install -y flatpak &>/dev/null || true
- Agregamos Flathub → flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>/dev/null || true
- Instalamos app de ejemplo (puede variar) → flatpak install -y flathub org.gnome.Calculator 2>/dev/null || echo 'Flatpak de ejemplo (puede necesitar red)'
- Listamos apps Flatpak → flatpak list | head -3 || true
ESTROFA: RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 4. Módulos AppStream
- Listamos módulos → dnf module list | head -4
- Habilitamos módulo de ejemplo → dnf module enable -y nodejs:18 2>/dev/null || echo 'Módulo ejemplo (puede variar)'
- Verificamos módulo → dnf module list --enabled | head -2 || true
ESTROFA: RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 5. Repositorio Local
- Preparamos directorio local → mkdir -p challenge/local-repo && cp /var/cache/dnf/*/*/packages/bash*.rpm challenge/local-repo/ 2>/dev/null || touch challenge/local-repo/dummy.rpm
- Creamos metadatos → createrepo challenge/local-repo
- Configuramos .repo local → echo '[my-local]
- Verificamos nuevo repo → dnf repolist | grep my-local || true

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
