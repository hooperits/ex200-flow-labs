# Esqueleto Video / Letras - 02-shell-scripting
# Generado desde: /home/juanca/proys/RHCSA-EX200/labs/02-shell-scripting/demo.sh
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

[00:00 - 00:48] - ESTROFA 1: 1. Variables y Aritmética

- **Declaramos una variable asignándole un valor de texto**
  ```
  CURSO='RHCSA EX200'
  ```

- **Imprimimos la variable usando el símbolo '\$'**
  ```
  echo \"Estamos estudiando el curso: \$CURSO\"
  ```

- **Declaramos dos variables numéricas**
  ```
  A=15; B=10
  ```

- **Realizamos una suma aritmética en Bash con \$((...))**
  ```
  echo \"La suma de A + B es: \$((A + B))\"
  ```

[00:48 - 01:36] - ESTROFA 2: 2. Condicionales

- **Comprobamos si el directorio /etc existe con el flag '-d'**
  ```
  if [ -d /etc ]; then echo 'El directorio /etc existe'; fi
  ```

- **Comprobamos si un archivo específico existe con el flag '-f'**
  ```
  if [ -f /etc/passwd ]; then echo 'El archivo /etc/passwd existe'; fi
  ```

- **Comparamos números usando '-gt' (Greater Than - Mayor que)**
  ```
  if [ 15 -gt 10 ]; then echo '15 es mayor que 10'; fi
  ```

- **Usamos una estructura completa con else**
  ```
  if [ 5 -eq 10 ]; then echo 'Son iguales'; else echo 'No son iguales'; fi
  ```

[01:36 - 02:24] - ESTROFA 3: 3. Bucles (for/while)

- **Bucle for simple para iterar sobre un rango numérico**
  ```
  for i in {1..3}; do echo \"Número de iteración: \$i\"; done
  ```

- **Bucle for para iterar sobre una lista de strings**
  ```
  for color in rojo verde azul; do echo \"Color: \$color\"; done
  ```

- **Bucle while que se ejecuta mientras la condición sea verdadera**
  ```
  count=1; while [ \$count -le 3 ]; do echo \"Contador: \$count\"; count=\$((count + 1)); done
  ```

- **Bucle for para iterar sobre archivos del sistema**
  ```
  for file in /etc/hostname /etc/resolv.conf; do ls -l \$file; done
  ```

[02:24 - 03:12] - ESTROFA 4: 4. Argumentos

- **Simulamos obtener el nombre del script usando '\$0'**
  ```
  echo 'Nombre del script en ejecución: \$0'
  ```

- **Simulamos leer el primer argumento posicional usando '\$1'**
  ```
  echo 'Primer argumento recibido: \$1'
  ```

- **Simulamos leer el número total de argumentos usando '\$#'**
  ```
  echo 'Número total de argumentos: \$#'
  ```

- **Simulamos imprimir todos los argumentos juntos usando '\$@'**
  ```
  echo 'Todos los argumentos recibidos: \$@'
  ```

[03:12 - 03:12] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~3 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Variables y Aritmética
- Declaramos una variable asignándole un valor de texto → CURSO='RHCSA EX200'
- Imprimimos la variable usando el símbolo '\$' → echo \"Estamos estudiando el curso: \$CURSO\"
- Declaramos dos variables numéricas → A=15; B=10
- Realizamos una suma aritmética en Bash con \$((...)) → echo \"La suma de A + B es: \$((A + B))\"
ESTROFA: 2. Condicionales
- Comprobamos si el directorio /etc existe con el flag '-d' → if [ -d /etc ]; then echo 'El directorio /etc existe'; fi
- Comprobamos si un archivo específico existe con el flag '-f' → if [ -f /etc/passwd ]; then echo 'El archivo /etc/passwd existe'; fi
- Comparamos números usando '-gt' (Greater Than - Mayor que) → if [ 15 -gt 10 ]; then echo '15 es mayor que 10'; fi
- Usamos una estructura completa con else → if [ 5 -eq 10 ]; then echo 'Son iguales'; else echo 'No son iguales'; fi
ESTROFA: 3. Bucles (for/while)
- Bucle for simple para iterar sobre un rango numérico → for i in {1..3}; do echo \"Número de iteración: \$i\"; done
- Bucle for para iterar sobre una lista de strings → for color in rojo verde azul; do echo \"Color: \$color\"; done
- Bucle while que se ejecuta mientras la condición sea verdadera → count=1; while [ \$count -le 3 ]; do echo \"Contador: \$count\"; count=\$((count + 1)); done
- Bucle for para iterar sobre archivos del sistema → for file in /etc/hostname /etc/resolv.conf; do ls -l \$file; done
ESTROFA: 4. Argumentos
- Simulamos obtener el nombre del script usando '\$0' → echo 'Nombre del script en ejecución: \$0'
- Simulamos leer el primer argumento posicional usando '\$1' → echo 'Primer argumento recibido: \$1'
- Simulamos leer el número total de argumentos usando '\$#' → echo 'Número total de argumentos: \$#'
- Simulamos imprimir todos los argumentos juntos usando '\$@' → echo 'Todos los argumentos recibidos: \$@'

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
