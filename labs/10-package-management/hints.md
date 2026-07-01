# Pistas del Reto: 10-Package-Management (RHEL 10)

## 1. Configurar un Repositorio
- Crea el archivo manualmente en `/etc/yum.repos.d/local-test.repo`
- Usa:
  ```
  [local-test]
  name=Local Test
  baseurl=file:///srv/nfs_export
  enabled=1
  gpgcheck=0
  ```
- Verifica: `dnf repolist`

## 2. Instalar y Gestionar Paquetes con DNF5
- `dnf install httpd`
- `dnf update bash`
- `dnf remove httpd`
- Nota: En RHEL 10 `dnf` usa DNF5 por defecto (más rápido).

## 3. Gestionar Aplicaciones con Flatpak
- `dnf install -y flatpak`
- `flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`
- Busca e instala: `flatpak search calculator` o `flatpak install flathub org.gnome.Calculator`
- Lista: `flatpak list`

## 4. Usar Módulos
- `dnf module list`
- `dnf module enable nodejs:18`
- `dnf module install nodejs:18/minimal`

## 5. Crear un Repositorio Local
- `mkdir -p challenge/local-repo`
- Copia RPMs (ej. desde /var/cache/dnf o /srv/nfs_export)
- `createrepo challenge/local-repo`
- Crea `/etc/yum.repos.d/my-local.repo` con `baseurl=file://.../challenge/local-repo`
- Verifica: `dnf repolist` y prueba instalar un paquete.

## Consejos generales
- Usa `dnf clean all` si los repos no refrescan.
- Para Flatpak sin GUI, elige paquetes pequeños o verifica con `flatpak list`.
- Ejecuta `./verify.sh` frecuentemente.
- Si algo falla: `./reset.sh` y empieza de nuevo.
