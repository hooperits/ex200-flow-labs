# Esqueleto Video / Letras - 01-essential-tools
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/01-essential-tools/demo.sh
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

[00:00 - 01:00] - ESTROFA 1: 1. Redirecciones (stdout/stderr) y Pipes

- **Redirigimos la salida estándar (stdout) a un archivo usando el operador '>'**
  ```
  echo 'Hola Estudiante EX200' > saludo.txt
  ```

- **Leemos el archivo creado para confirmar su contenido**
  ```
  cat saludo.txt
  ```

- **Redirigimos el canal de error (stderr, descriptor 2) a otro archivo usando '2>'**
  ```
  ls archivo_inexistente.txt 2> error.log
  ```

- **Leemos el archivo de errores**
  ```
  cat error.log
  ```

- **Usamos un pipe '|' para enviar la salida de un comando como entrada de otro**
  ```
  echo -e 'rojo\nverde\nazul\namarillo' | grep 'a'
  ```

[01:00 - 01:30] - ESTROFA 2: 2. Filtrado con grep y Expresiones Regulares

- **Creamos un archivo temporal con varios registros de prueba**
  ```
  echo -e 'EX200: Permisos\nEX200: Redes\nOTRO: Linux\nEX200: Storage' > temas.txt
  ```

- **Usamos grep con expresión regular '^EX200:' para buscar líneas que inicien con ese texto**
  ```
  grep -E '^EX200:' temas.txt
  ```

[01:30 - 02:54] - ESTROFA 3: 3. Enlaces Duros (Hard Links) y Simbólicos (Soft Links) + Archivación y Compresión con tar

- **Creamos un archivo base de origen**
  ```
  echo 'Datos Importantes' > original.txt
  ```

- **Creamos un enlace duro que compartirá el mismo inodo que el archivo original**
  ```
  ln original.txt enlace_duro.txt
  ```

- **Creamos un enlace simbólico (o de tipo soft) usando la opción '-s'**
  ```
  ln -s original.txt enlace_simbolico.txt
  ```

- **Listamos los archivos mostrando el número de inodo ('-i') para comparar**
  ```
  ls -li original.txt enlace_duro.txt enlace_simbolico.txt
  ```

- **Creamos dos archivos de texto temporales**
  ```
  touch archivo_a.txt archivo_b.txt
  ```

- **Creamos un archivo empaquetado y comprimido en formato gzip con 'tar -czvf'**
  ```
  tar -czvf backup.tar.gz archivo_a.txt archivo_b.txt
  ```

- **Listamos el contenido del archivo comprimido sin extraerlo usando '-tzf'**
  ```
  tar -tzf backup.tar.gz
  ```

[02:54 - 04:06] - ESTROFA 4: 4. Permisos de Archivos (chmod / chown)

- **Creamos un archivo para pruebas de permisos**
  ```
  touch secreto.txt
  ```

- **Revisamos los permisos iniciales con ls -l**
  ```
  ls -l secreto.txt
  ```

- **Modificamos los permisos a 640 (lectura/escritura dueño, lectura grupo, nada para otros)**
  ```
  chmod 640 secreto.txt
  ```

- **Validamos el cambio en la lista de permisos**
  ```
  ls -l secreto.txt
  ```

- **Cambiamos el grupo propietario del archivo secreto a 'vagrant'**
  ```
  chown :vagrant secreto.txt
  ```

- **Verificamos los propietarios y grupos finales**
  ```
  ls -l secreto.txt
  ```

[04:06 - 04:06] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~4 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Redirecciones (stdout/stderr) y Pipes
- Redirigimos la salida estándar (stdout) a un archivo usando el operador '>' → echo 'Hola Estudiante EX200' > saludo.txt
- Leemos el archivo creado para confirmar su contenido → cat saludo.txt
- Redirigimos el canal de error (stderr, descriptor 2) a otro archivo usando '2>' → ls archivo_inexistente.txt 2> error.log
- Leemos el archivo de errores → cat error.log
- Usamos un pipe '|' para enviar la salida de un comando como entrada de otro → echo -e 'rojo\nverde\nazul\namarillo' | grep 'a'
ESTROFA: 2. Filtrado con grep y Expresiones Regulares
- Creamos un archivo temporal con varios registros de prueba → echo -e 'EX200: Permisos\nEX200: Redes\nOTRO: Linux\nEX200: Storage' > temas.txt
- Usamos grep con expresión regular '^EX200:' para buscar líneas que inicien con ese texto → grep -E '^EX200:' temas.txt
ESTROFA: 3. Enlaces Duros (Hard Links) y Simbólicos (Soft Links) + Archivación y Compresión con tar
- Creamos un archivo base de origen → echo 'Datos Importantes' > original.txt
- Creamos un enlace duro que compartirá el mismo inodo que el archivo original → ln original.txt enlace_duro.txt
- Creamos un enlace simbólico (o de tipo soft) usando la opción '-s' → ln -s original.txt enlace_simbolico.txt
- Listamos los archivos mostrando el número de inodo ('-i') para comparar → ls -li original.txt enlace_duro.txt enlace_simbolico.txt
- Creamos dos archivos de texto temporales → touch archivo_a.txt archivo_b.txt
- Creamos un archivo empaquetado y comprimido en formato gzip con 'tar -czvf' → tar -czvf backup.tar.gz archivo_a.txt archivo_b.txt
- Listamos el contenido del archivo comprimido sin extraerlo usando '-tzf' → tar -tzf backup.tar.gz
ESTROFA: 4. Permisos de Archivos (chmod / chown)
- Creamos un archivo para pruebas de permisos → touch secreto.txt
- Revisamos los permisos iniciales con ls -l → ls -l secreto.txt
- Modificamos los permisos a 640 (lectura/escritura dueño, lectura grupo, nada para otros) → chmod 640 secreto.txt
- Validamos el cambio en la lista de permisos → ls -l secreto.txt
- Cambiamos el grupo propietario del archivo secreto a 'vagrant' → chown :vagrant secreto.txt
- Verificamos los propietarios y grupos finales → ls -l secreto.txt

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
