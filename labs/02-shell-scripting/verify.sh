#!/bin/bash

# ANSI colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"
SCRIPT_FILE="$CHALLENGE_DIR/file_filter.sh"

FAILED_TESTS=0

print_result() {
    local test_name="$1"
    local status="$2"
    local message="$3"
    
    if [ "$status" = "SUCCESS" ]; then
        echo -e "[ ${GREEN}PASSED${NC} ] $test_name - $message"
    else
        echo -e "[ ${RED}FAILED${NC} ] $test_name - $message"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
}

echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}         Evaluador de Reto: Módulo 02 - Shell Scripting         ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 0. Verificar que el script del estudiante exista y sea ejecutable
if [ ! -f "$SCRIPT_FILE" ]; then
    print_result "Existencia del Script" "FAIL" "No se encontró el archivo '$SCRIPT_FILE'."
    exit 1
fi

if [ ! -x "$SCRIPT_FILE" ]; then
    print_result "Permisos de Ejecución" "FAIL" "El script '$SCRIPT_FILE' no tiene permisos de ejecución (chmod +x)."
    exit 1
fi
print_result "Prerrequisitos" "SUCCESS" "El script existe y es ejecutable."

# Crear directorio de pruebas dinámico
TEST_DIR="$CHALLENGE_DIR/test_dir"
rm -rf "$TEST_DIR"
mkdir -p "$TEST_DIR"
touch "$TEST_DIR/documento1.txt"
touch "$TEST_DIR/documento2.txt"
touch "$TEST_DIR/servidor.log"
touch "$TEST_DIR/notas.md"

# 1. Prueba: Menos de 2 parámetros (Esperado: código de salida 1, salida en stderr)
ERR_OUT_1=$( "$SCRIPT_FILE" "$TEST_DIR" 2>&1 >/dev/null )
EXIT_CODE_1=$?

if [ $EXIT_CODE_1 -eq 1 ] && [ -n "$ERR_OUT_1" ]; then
    print_result "Control de Parámetros (Faltantes)" "SUCCESS" "El script falló con código 1 y arrojó mensaje en stderr."
else
    print_result "Control de Parámetros (Faltantes)" "FAIL" "Se obtuvo código $EXIT_CODE_1 en vez de 1, o no hubo mensaje en stderr."
fi

# 2. Prueba: Directorio inexistente (Esperado: código de salida 2, salida en stderr)
ERR_OUT_2=$( "$SCRIPT_FILE" "$CHALLENGE_DIR/inexistente" "txt" 2>&1 >/dev/null )
EXIT_CODE_2=$?

if [ $EXIT_CODE_2 -eq 2 ] && [ -n "$ERR_OUT_2" ]; then
    print_result "Validación de Directorio (Inexistente)" "SUCCESS" "El script falló con código 2 al pasar un directorio inválido."
else
    print_result "Validación de Directorio (Inexistente)" "FAIL" "Se obtuvo código $EXIT_CODE_2 en vez de 2, o no hubo mensaje en stderr."
fi

# 3. Prueba: Sin coincidencia de archivos (Esperado: código de salida 3, mensaje en stdout)
STDOUT_3=$( "$SCRIPT_FILE" "$TEST_DIR" "pdf" 2>/dev/null )
EXIT_CODE_3=$?

if [ $EXIT_CODE_3 -eq 3 ] && [ -n "$STDOUT_3" ]; then
    print_result "Sin Coincidencia de Extensión" "SUCCESS" "El script retornó código 3 y arrojó mensaje en stdout."
else
    print_result "Sin Coincidencia de Extensión" "FAIL" "Se obtuvo código $EXIT_CODE_3 en vez de 3, o no hubo mensaje en stdout."
fi

# 4. Prueba: Éxito con coincidencia (Esperado: código de salida 0, lista de archivos en stdout)
STDOUT_4=$( "$SCRIPT_FILE" "$TEST_DIR" "txt" 2>/dev/null | sort | xargs )
EXIT_CODE_4=$?

if [ $EXIT_CODE_4 -eq 0 ] && [[ "$STDOUT_4" == "documento1.txt documento2.txt" ]]; then
    print_result "Filtrado de Archivos Exitoso" "SUCCESS" "El script retornó código 0 y listó correctamente los archivos."
else
    print_result "Filtrado de Archivos Exitoso" "FAIL" "Se obtuvo código $EXIT_CODE_4 en vez de 0, o los archivos listados son incorrectos ('$STDOUT_4')."
fi

# Limpiar directorio de pruebas dinámico
rm -rf "$TEST_DIR"

echo
echo -e "${CYAN}================================================================${NC}"
if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}      RESULTADO FINAL: ¡TODAS LAS PRUEBAS PASARON CON ÉXITO! (PASSED)${NC}"
    echo -e "${CYAN}================================================================${NC}"
    exit 0
else
    echo -e "${RED}      RESULTADO FINAL: ALGUNAS PRUEBAS FALLARON. (FAILED)${NC}"
    echo -e "${CYAN}================================================================${NC}"
    exit 1
fi
