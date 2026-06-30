#!/bin/bash
# lib/demo-common.sh
# Helpers comunes para los demos de los laboratorios.
# Soporta modos --video y --fast para producción de contenido.
# Toda la narrativa en español. Comandos y términos técnicos en inglés.
#
# Uso en demo.sh:
#   source "$(dirname "$0")/../../lib/demo-common.sh"
#   # luego usa clear_section y run_demo_cmd

# Colores ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# Modo video / fast
VIDEO_MODE=false
FAST_MODE=false
while [[ $# -gt 0 ]]; do
  case $1 in
    --video) VIDEO_MODE=true; shift ;;
    --fast) FAST_MODE=true; shift ;;
    *) shift ;;
  esac
done

get_delay() {
  if $FAST_MODE || $VIDEO_MODE; then echo "0.01"; else echo "0.03"; fi
}

get_cmd_sleep() {
  if $FAST_MODE || $VIDEO_MODE; then echo "0.3"; else echo "5.0"; fi
}

get_explain_sleep() {
  if $FAST_MODE || $VIDEO_MODE; then echo "0.2"; else echo "1.0"; fi
}

# Simula tipeo de texto
type_text() {
    local text="$1"
    local delay=$(get_delay)
    for ((i=0; i<${#text}; i++)); do
        echo -n -e "${text:$i:1}"
        sleep "$delay"
    done
    echo
}

# Muestra explicación, "tipea" el comando y lo ejecuta
run_demo_cmd() {
    local cmd="$2"
    echo -e "${MAGENTA}➔ Explicación:${NC} ${YELLOW}$1${NC}"
    sleep $(get_explain_sleep)
    echo -n -e "${BLUE}vagrant@localhost:~$ ${NC}"
    type_text "$cmd"
    sleep 0.5

    # Quita comentarios entre paréntesis para eval seguro
    local exec_cmd
    exec_cmd=$(echo "$cmd" | sed 's/ ([^)]*)$//')
    eval "$exec_cmd"
    echo
    sleep $(get_cmd_sleep)
}

# Limpia pantalla y muestra encabezado de sección
# El llamador debe pasar el título completo (ej: "RHCSA Módulo 01: ... - Tema: Redirecciones")
clear_section() {
    local title="$1"
    clear
    echo -e "${CYAN}================================================================${NC}"
    echo -e "${CYAN}    $title${NC}"
    echo -e "${CYAN}================================================================${NC}"
    echo
    if $FAST_MODE || $VIDEO_MODE; then
      sleep 0.3
    else
      sleep 2.0
    fi
}