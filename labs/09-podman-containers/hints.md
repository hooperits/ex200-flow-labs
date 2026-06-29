# Pistas del Reto: 09-podman-containers

## 1. Crear y Ejecutar el Contenedor
* Primero, crea el directorio en el host:
  ```bash
  mkdir -p /home/vagrant/html
  ```
* Corre el contenedor mapeando el puerto 8080 y montando el volumen con el flag de SELinux `:Z` (requerido para dar acceso a Podman en modo rootless):
  ```bash
  podman run -d --name web-server -p 8080:8080 -v /home/vagrant/html:/usr/share/nginx/html:Z registry.access.redhat.com/ubi9/nginx-120
  ```

## 2. Generar el Servicio systemd del Usuario
* Crea la estructura de directorios necesaria para guardar configuraciones de usuario en systemd:
  ```bash
  mkdir -p ~/.config/systemd/user/
  cd ~/.config/systemd/user/
  ```
* Genera los archivos de servicio usando `podman generate systemd`:
  ```bash
  podman generate systemd --new --files --name web-server
  ```
* Recarga el daemon de systemd a nivel de usuario para que lea el nuevo archivo:
  ```bash
  systemctl --user daemon-reload
  ```
* Habilita el servicio (no uses `sudo` aquí, ya que es a nivel de usuario):
  ```bash
  systemctl --user enable container-web-server.service
  ```

## 3. Habilitar Linger
* Linger permite que los servicios de usuario inicien en el arranque y continúen en ejecución sin sesiones abiertas. Requiere privilegios administrativos:
  ```bash
  sudo loginctl enable-linger vagrant
  ```
* Puedes comprobar que está activo con:
  ```bash
  loginctl show-user vagrant | grep Linger
  ```
