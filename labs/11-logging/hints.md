# Pistas del Reto: 11-Logging

## 1. Configurar un Repositorio DNF
- Usa `dnf config-manager --add-repo` o crea manualmente el .repo en /etc/yum.repos.d/
- Para local: baseurl=file:///path
- Verifica con `dnf repolist`

## 2. Instalar y Gestionar Paquetes
- `dnf install paquete`
- `dnf update paquete`
- `dnf remove paquete`
- `dnf search` y `dnf info`

## 3. Usar Módulos DNF
- `dnf module list`
- `dnf module enable nombre:stream`
- `dnf module install nombre:stream/perfil`

## 4. Crear un Repositorio Local
- `mkdir /tmp/mi-repo`
- Copia RPMs
- `createrepo /tmp/mi-repo`
- Crea .repo apuntando a file://

## Evaluación
- Ejecuta `./verify.sh` después de completar.
- Usa `./reset.sh` para limpiar.
