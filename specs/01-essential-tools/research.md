# Research: 01-essential-tools

Este documento registra los hallazgos y decisiones técnicas tomadas para el diseño del laboratorio de herramientas esenciales.

## Decisiones de Diseño

### 1. Validación No Destructiva de Enlaces (Links)
* **Decisión**: Utilizar el operador de comparación de inodos de Bash `-ef` para validar enlaces duros y `readlink` + `[ -L ]` para enlaces simbólicos.
* **Racional**:
  - Para enlaces duros, `[ archivo1 -ef archivo2 ]` comprueba si ambos apuntan al mismo inodo y residen en el mismo sistema de archivos. Esto es robusto y no requiere extraer el número del inodo manualmente con `stat` o `ls`.
  - Para enlaces simbólicos, `[ -L archivo ]` comprueba que el archivo es un enlace simbólico, y `readlink` lee el destino exacto para verificar que no esté roto y apunte a `original_data.txt`.
* **Alternativas consideradas**:
  - Comparación manual de inodos con `stat -c "%i"` y `diff`: Funciona, pero es más propenso a errores de formato y menos limpio en Bash que `-ef`.

### 2. Validación de Permisos y Propietarios
* **Decisión**: Consultar el estado del sistema usando `stat` con formatos específicos.
  - Para permisos en formato octal (ej: `640`): `stat -c "%a"`
  - Para grupo propietario: `stat -c "%G"`
* **Racional**: `stat` proporciona una salida estructurada de manera directa, evitando procesamientos pesados e imprecisos de cadenas de texto generadas por `ls -l` y `awk`.
* **Alternativas consideradas**:
  - Parsing de `ls -l`: Descartado por complejidad y variabilidad de formatos entre sistemas de archivos o localizaciones.

### 3. Simulación de Tipeado Animado en la Demo
* **Decisión**: Implementar una función en Bash `type_text` que procese carácter por carácter un texto y aplique un retardo programado de `0.01` a `0.02` segundos.
* **Racional**: Genera el efecto visual premium requerido sin depender de utilidades externas (como `asciinema` o `expect`) y cumple con el límite de duración inferior a 3 minutos para todo el script.

* **Racional**:
  - Permite que el código sea portable tanto en Windows (PowerShell/CMD) como en Linux/WSL, evitando acoplar rutas absolutas que incluyan nombres de usuarios específicos del sistema (como `/home/juanca/`).
