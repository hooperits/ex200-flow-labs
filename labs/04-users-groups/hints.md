# Pistas del Reto: 04-users-groups

## 1. Creación de Usuarios y Grupos
* Para crear un grupo:
  ```bash
  sudo groupadd sysadmin
  ```
* Para crear el usuario `operator1` con shell restrictivo y grupo secundario:
  ```bash
  sudo useradd -s /sbin/nologin -G sysadmin operator1
  ```
* Crea el usuario `auditor1` de forma estándar:
  ```bash
  sudo useradd auditor1
  ```

## 2. Directorio y SGID
* Crea el directorio:
  ```bash
  sudo mkdir -p /srv/sysadmin_docs
  ```
* Cambia la pertenencia de grupo propietario:
  ```bash
  sudo chown :sysadmin /srv/sysadmin_docs
  ```
* Aplica permisos combinando permisos estándar (770) con SGID (el valor especial 2 al inicio):
  ```bash
  sudo chmod 2770 /srv/sysadmin_docs
  ```
  *(O alternativamente: `sudo chmod g+s /srv/sysadmin_docs` y `sudo chmod 770 /srv/sysadmin_docs`).*

## 3. Asignación de ACLs
* Para dar acceso exclusivo al usuario `auditor1` de lectura y ejecución (`r-x`):
  ```bash
  sudo setfacl -m u:auditor1:rx /srv/sysadmin_docs
  ```
* Puedes comprobar que se asignó correctamente ejecutando `getfacl /srv/sysadmin_docs`.
