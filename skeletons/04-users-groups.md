# Esqueleto Video / Letras - 04-users-groups
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/04-users-groups/demo.sh
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

[00:00 - 00:48] - ESTROFA 1: 1. Administración de Usuarios

- **Buscamos información de nuestro usuario actual en /etc/passwd**
  ```
  grep '^vagrant' /etc/passwd
  ```

- **Simulamos la creación de un usuario con ID y Shell específicos**
  ```
  echo 'useradd -u 2001 -s /sbin/nologin user_test'
  ```

- **Simulamos modificar la pertenencia a grupos secundarios de un usuario**
  ```
  echo 'usermod -aG wheel user_test'
  ```

- **Mostramos la información de expiración de contraseña de un usuario con chage**
  ```
  sudo chage -l vagrant | head -n 5
  ```

[00:48 - 01:36] - ESTROFA 2: 2. Administración de Grupos

- **Listamos algunos grupos definidos en el sistema**
  ```
  tail -n 5 /etc/group
  ```

- **Simulamos crear un nuevo grupo de trabajo**
  ```
  echo 'groupadd sysadmins'
  ```

- **Verificamos los grupos a los que pertenece el usuario actual**
  ```
  groups
  ```

- **Mostramos la pertenencia de un usuario con el comando id**
  ```
  id vagrant
  ```

[01:36 - 02:36] - ESTROFA 3: 3. Permisos Especiales (SGID)

- **Creamos un directorio temporal para pruebas de permisos**
  ```
  mkdir -p docs_temp
  ```

- **Asignamos el bit SGID al directorio (los archivos heredan el grupo)**
  ```
  chmod g+s docs_temp
  ```

- **Mostramos los permisos del directorio para visualizar la 's' de SGID**
  ```
  ls -ld docs_temp
  ```

- **Asignamos el Sticky Bit a un directorio (solo el dueño borra sus archivos)**
  ```
  chmod +t docs_temp
  ```

- **Visualizamos la 't' del Sticky Bit en los permisos de otros**
  ```
  ls -ld docs_temp
  ```

[02:36 - 03:36] - ESTROFA 4: 4. ACLs

- **Creamos un archivo temporal para pruebas de ACLs**
  ```
  touch notas_acl.txt
  ```

- **Leemos las ACLs por defecto del archivo usando getfacl**
  ```
  getfacl notas_acl.txt
  ```

- **Asignamos un permiso de lectura específico a un usuario ficticio con setfacl**
  ```
  setfacl -m u:nobody:r notas_acl.txt
  ```

- **Comprobamos el cambio en las ACLs y vemos el signo '+' en los permisos**
  ```
  getfacl notas_acl.txt
  ```

- **Eliminamos todas las ACLs asignadas al archivo**
  ```
  setfacl -b notas_acl.txt
  ```

[03:36 - 03:36] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~3 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Administración de Usuarios
- Buscamos información de nuestro usuario actual en /etc/passwd → grep '^vagrant' /etc/passwd
- Simulamos la creación de un usuario con ID y Shell específicos → echo 'useradd -u 2001 -s /sbin/nologin user_test'
- Simulamos modificar la pertenencia a grupos secundarios de un usuario → echo 'usermod -aG wheel user_test'
- Mostramos la información de expiración de contraseña de un usuario con chage → sudo chage -l vagrant | head -n 5
ESTROFA: 2. Administración de Grupos
- Listamos algunos grupos definidos en el sistema → tail -n 5 /etc/group
- Simulamos crear un nuevo grupo de trabajo → echo 'groupadd sysadmins'
- Verificamos los grupos a los que pertenece el usuario actual → groups
- Mostramos la pertenencia de un usuario con el comando id → id vagrant
ESTROFA: 3. Permisos Especiales (SGID)
- Creamos un directorio temporal para pruebas de permisos → mkdir -p docs_temp
- Asignamos el bit SGID al directorio (los archivos heredan el grupo) → chmod g+s docs_temp
- Mostramos los permisos del directorio para visualizar la 's' de SGID → ls -ld docs_temp
- Asignamos el Sticky Bit a un directorio (solo el dueño borra sus archivos) → chmod +t docs_temp
- Visualizamos la 't' del Sticky Bit en los permisos de otros → ls -ld docs_temp
ESTROFA: 4. ACLs
- Creamos un archivo temporal para pruebas de ACLs → touch notas_acl.txt
- Leemos las ACLs por defecto del archivo usando getfacl → getfacl notas_acl.txt
- Asignamos un permiso de lectura específico a un usuario ficticio con setfacl → setfacl -m u:nobody:r notas_acl.txt
- Comprobamos el cambio en las ACLs y vemos el signo '+' en los permisos → getfacl notas_acl.txt
- Eliminamos todas las ACLs asignadas al archivo → setfacl -b notas_acl.txt

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
