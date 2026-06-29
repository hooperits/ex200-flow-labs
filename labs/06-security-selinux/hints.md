# Pistas del Reto: 06-security-selinux

## 1. Configurar firewalld
* Agrega de forma permanente el servicio:
  ```bash
  sudo firewall-cmd --permanent --add-service=http
  ```
* Agrega de forma permanente el puerto:
  ```bash
  sudo firewall-cmd --permanent --add-port=82/tcp
  ```
* Recarga las configuraciones del cortafuegos:
  ```bash
  sudo firewall-cmd --reload
  ```

## 2. Definir y Aplicar Contextos de SELinux
* Primero, crea el directorio requerido:
  ```bash
  sudo mkdir -p /var/www/custom_html
  ```
* Declara la regla de contexto en la base de datos de SELinux (usa comillas para la expresión regular y asegúrate del tipo de contexto):
  ```bash
  sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/custom_html(/.*)?"
  ```
* Aplica físicamente la regla restaurando los contextos del directorio de forma recursiva (`-R`) y detallada (`-v`):
  ```bash
  sudo restorecon -R -v /var/www/custom_html
  ```

## 3. Configurar Booleanos de SELinux
* Para activar de manera persistente (persistente: `-P`) el booleano:
  ```bash
  sudo setsebool -P httpd_enable_homedirs on
  ```
* Puedes comprobar el estado actual con `getsebool httpd_enable_homedirs`.
