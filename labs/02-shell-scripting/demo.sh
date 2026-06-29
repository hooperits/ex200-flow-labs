#!/bin/bash

# ANSI colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Helper for simulated typing
type_text() {
    local text="$1"
    local delay="${2:-0.03}"
    for ((i=0; i<${#text}; i++)); do
        echo -n -e "${text:$i:1}"
        sleep "$delay"
    done
    echo
}

# Helper to show a command being typed and then execute it
run_demo_cmd() {
    local cmd="$2"
    echo -e "${MAGENTA}➔ Explicación:${NC} ${YELLOW}$1${NC}"
    sleep 1.0
    echo -n -e "${BLUE}vagrant@localhost:~$ ${NC}"
    type_text "$cmd" 0.03
    sleep 0.8
    eval "$cmd"
    echo
    sleep 5.0
}

# Helper to clean terminal and show section header
clear_section() {
    clear
    echo -e "${CYAN}================================================================${NC}"
    echo -e "${CYAN}    RHCSA Módulo 02: Scripting y Automatización en Bash         ${NC}"
    echo -e "${CYAN}    Tema: $1${NC}"
    echo -e "${CYAN}================================================================${NC}"
    echo
    sleep 2.0
}

# 1. Variables y Aritmética
clear_section "1. Definición de Variables y Operaciones Aritméticas"
run_demo_cmd "Declaramos una variable asignándole un valor de texto" "CURSO='RHCSA EX200'"
run_demo_cmd "Imprimimos la variable usando el símbolo '\$'" "echo \"Estamos estudiando el curso: \$CURSO\""
run_demo_cmd "Declaramos dos variables numéricas" "A=15; B=10"
run_demo_cmd "Realizamos una suma aritmética en Bash con \$((...))" "echo \"La suma de A + B es: \$((A + B))\""
sleep 2.0

# 2. Estructuras Condicionales (if/then/else)
clear_section "2. Condicionales (if/then/else) en Archivos y Números"
run_demo_cmd "Comprobamos si el directorio /etc existe con el flag '-d'" "if [ -d /etc ]; then echo 'El directorio /etc existe'; fi"
run_demo_cmd "Comprobamos si un archivo específico existe con el flag '-f'" "if [ -f /etc/passwd ]; then echo 'El archivo /etc/passwd existe'; fi"
run_demo_cmd "Comparamos números usando '-gt' (Greater Than - Mayor que)" "if [ 15 -gt 10 ]; then echo '15 es mayor que 10'; fi"
run_demo_cmd "Usamos una estructura completa con else" "if [ 5 -eq 10 ]; then echo 'Son iguales'; else echo 'No son iguales'; fi"
sleep 2.0

# 3. Bucles (Loops) for y while
clear_section "3. Estructuras de Repetición: Bucles for y while"
run_demo_cmd "Bucle for simple para iterar sobre un rango numérico" "for i in {1..3}; do echo \"Número de iteración: \$i\"; done"
run_demo_cmd "Bucle for para iterar sobre una lista de strings" "for color in rojo verde azul; do echo \"Color: \$color\"; done"
run_demo_cmd "Bucle while que se ejecuta mientras la condición sea verdadera" "count=1; while [ \$count -le 3 ]; do echo \"Contador: \$count\"; count=\$((count + 1)); done"
run_demo_cmd "Bucle for para iterar sobre archivos del sistema" "for file in /etc/hostname /etc/resolv.conf; do ls -l \$file; done"
sleep 2.0

# 4. Parámetros y Argumentos de Script
clear_section "4. Manejo de Argumentos dentro de un Script"
run_demo_cmd "Simulamos obtener el nombre del script usando '\$0'" "echo 'Nombre del script en ejecución: \$0'"
run_demo_cmd "Simulamos leer el primer argumento posicional usando '\$1'" "echo 'Primer argumento recibido: \$1'"
run_demo_cmd "Simulamos leer el número total de argumentos usando '\$#'" "echo 'Número total de argumentos: \$#'"
run_demo_cmd "Simulamos imprimir todos los argumentos juntos usando '\$@'" "echo 'Todos los argumentos recibidos: \$@'"
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
