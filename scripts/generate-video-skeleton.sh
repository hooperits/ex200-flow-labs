#!/bin/bash
# scripts/generate-video-skeleton.sh
#
# Genera esqueletos profesionales de video/letras + prompts de Suno
# a partir de los demo.sh para el proyecto RHCSA EX200.
#
# Características avanzadas:
# - Estimación automática de tiempos basada en número de comandos
# - Estructura CORO / ESTROFAS / OUTRO
# - Generación de prompts listos para Suno
# - Esqueleto maestro combinado para toda la serie
#
# Uso:
#   ./scripts/generate-video-skeleton.sh labs/01-essential-tools/demo.sh
#   ./scripts/generate-video-skeleton.sh --all
#
# Salida: 
# - esqueletos/<modulo>.md (con timings y estructura)
# - esqueletos/suno-prompts/<modulo>.txt (prompts directos para Suno)
# - esqueletos/MASTER-SERIES.md (resumen de toda la serie)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OUTPUT_DIR="$PROJECT_ROOT/skeletons"
SUNO_DIR="$OUTPUT_DIR/suno-prompts"

mkdir -p "$OUTPUT_DIR" "$SUNO_DIR"

# Tiempo base por comando en segundos (ajustable)
SECONDS_PER_COMMAND=12
INTRO_SECONDS=25
OUTRO_SECONDS=20

# === SUNO PROMPT STYLE DEFINITION (see ANTI-LOOP RULE in AGENTS.md) ===
# Edit the style description in ONE PLACE only.
# Do NOT repeatedly tweak wording via micro-edits.
# Goal characteristics (for fast technical Spanish rap):
# - Extremely high speed chopper flow
# - Very dense, complex multisyllabic rhymes
# - Impeccable diction and clarity even at top speed
# - Technical, precise, aggressive delivery with high rhythmic complexity
SUNO_STYLE="Genera un rap agresivo en español con un flujo chopper de velocidad máxima, rimas multisilábicas muy densas y complejas, dicción impecable incluso a alta velocidad y un estilo técnico, preciso y agresivo con gran complejidad rítmica y alto nivel técnico."
SUNO_CLOSING="Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas."

generate_skeleton() {
  local DEMO_FILE="$1"
  local BASENAME
  BASENAME=$(basename "$(dirname "$DEMO_FILE")")
  local OUTPUT_FILE="$OUTPUT_DIR/${BASENAME}.md"
  local SUNO_FILE="$SUNO_DIR/${BASENAME}.txt"

  if [ ! -f "$DEMO_FILE" ]; then
    echo "Error: Archivo no encontrado: $DEMO_FILE" >&2
    return 1
  fi

  # Extraer información del módulo
  MODULE_NAME=$(grep -o 'Módulo [0-9]\+:' "$DEMO_FILE" | head -1 | sed 's/://' || echo "Módulo")
  MODULE_NUMBER=$(echo "$BASENAME" | cut -d'-' -f1)

  # Usar awk para extraer secciones + comandos + conteo
  awk -v module="$MODULE_NAME" -v sec_per_cmd="$SECONDS_PER_COMMAND" '
  BEGIN {
    section_num = 0;
    total_commands = 0;
    current_section = "";
    current_cmds = 0;
    section_cmds[0] = 0;
    section_titles[0] = "";
  }
  /clear_section "/ {
    if (section_num > 0) {
      section_cmds[section_num] = current_cmds;
      total_commands += current_cmds;
    }
    title = $0;
    gsub(/.*clear_section "/, "", title);
    gsub(/".*/, "", title);
    gsub(/^RHCSA Módulo [0-9]+: .* - Tema: /, "", title);
    
    section_num++;
    section_titles[section_num] = title;
    current_cmds = 0;
    next;
  }
  /run_demo_cmd "/ {
    cmd = $0;
    gsub(/.*run_demo_cmd "[^"]*" "/, "", cmd);
    gsub(/"$/, "", cmd);
    gsub(/ \([^)]*\)$/, "", cmd);
    if (cmd != "") {
      current_cmds++;
      expl = $0;
      gsub(/.*run_demo_cmd "/, "", expl);
      gsub(/" .*$/, "", expl);
      commands[section_num, current_cmds] = cmd;
      explanations[section_num, current_cmds] = expl;
    }
  }
  END {
    if (section_num > 0) {
      section_cmds[section_num] = current_cmds;
      total_commands += current_cmds;
    }

    # Calcular tiempos
    current_time = 0;
    print "### CORO / Intro";
    print "[00:00 - 00:" sprintf("%02d", INTRO_SECONDS) "] - INTRO / GANCHO";
    print "";
    current_time = INTRO_SECONDS;

    for (s = 1; s <= section_num; s++) {
      cmds_in_section = section_cmds[s];
      section_time = cmds_in_section * sec_per_cmd;
      if (section_time < 25) section_time = 30;  # mínimo por estrofa

      start_min = int(current_time / 60);
      start_sec = current_time % 60;
      end_time = current_time + section_time;
      end_min = int(end_time / 60);
      end_sec = end_time % 60;

      printf "[%02d:%02d - %02d:%02d] - ", start_min, start_sec, end_min, end_sec;

      if (s == 1) {
        print "ESTROFA 1: " section_titles[s];
      } else {
        print "ESTROFA " s ": " section_titles[s];
      }
      print "";

      for (c = 1; c <= cmds_in_section; c++) {
        printf "- **%s**\n", explanations[s, c];
        printf "  ```\n";
        printf "  %s\n", commands[s, c];
        printf "  ```\n";
        print "";
      }

      current_time = end_time;
    }

    # OUTRO
    outro_start = current_time;
    outro_end = current_time + OUTRO_SECONDS;
    printf "[%02d:%02d - %02d:%02d] - OUTRO / CIERRE\n", int(outro_start/60), outro_start%60, int(outro_end/60), outro_end%60;
    print "";
    print "- Recordatorio final + llamada a practicar el reto";
    print "";
    print "Tiempo total estimado del video: ~" int(current_time / 60) " minutos";
  }
  ' "$DEMO_FILE" > /tmp/skeleton_body_$$.txt

  # === GENERAR ARCHIVO PRINCIPAL DEL ESQUELETO ===
  {
    echo "# Esqueleto Video / Letras - $BASENAME"
    echo "# Generado desde: $DEMO_FILE"
    echo "# Fecha: $(date +%Y-%m-%d)"
    echo "#"
    echo "# Instrucciones:"
    echo "# - Alinea con las letras en RHCSA-EX200-lyrics/."
    echo "# - Los tiempos son estimados (12s por comando aprox)."
    echo "# - Ejecuta con \`--video\` para tiempos reales."
    echo "# - Comandos en inglés | Narrativa en español."
    echo ""

    echo "## Estructura sugerida del video/rap"
    echo ""
    cat /tmp/skeleton_body_$$.txt

    echo ""
    echo "## Prompt listo para Suno AI (copia y pega)"
  } > "$OUTPUT_FILE"

  # === GENERAR PROMPT DE SUNO SEPARADO ===
  # Uses centralized SUNO_STYLE + SUNO_CLOSING (ANTI-LOOP RULE: single source of truth)
  {
    echo "$SUNO_STYLE"
    echo "Estructura: CORO + 4-5 ESTROFAS + OUTRO."
    echo "Incluye estos conceptos clave con sus comandos:"
    echo ""

    awk '
    /clear_section "/ {
      title = $0; gsub(/.*clear_section "/,"",title); gsub(/".*/,"",title);
      gsub(/^RHCSA Módulo [0-9]+: .* - Tema: /, "", title);
      print "ESTROFA: " title
    }
    /run_demo_cmd "/ {
      expl = $0; gsub(/.*run_demo_cmd "/,"",expl); gsub(/" .*$/,"",expl);
      cmd = $0; gsub(/.*run_demo_cmd "[^"]*" "/,"",cmd); gsub(/"$/,"",cmd);
      gsub(/ \([^)]*\)$/, "", cmd);
      print "- " expl " → " cmd
    }
    ' "$DEMO_FILE"

    echo ""
    echo "$SUNO_CLOSING"
  } > "$SUNO_FILE"

  # Añadir prompt al esqueleto principal también
  cat "$SUNO_FILE" >> "$OUTPUT_FILE"

  echo "Generado: $OUTPUT_FILE"
  echo "Prompt Suno: $SUNO_FILE"

  rm -f /tmp/skeleton_body_$$.txt
}

# === GENERAR MASTER DE LA SERIE ===
generate_master() {
  local MASTER_FILE="$OUTPUT_DIR/MASTER-SERIES.md"

  {
    echo "# MASTER: Esqueletos de toda la serie RHCSA EX200"
    echo "# Generado: $(date +%Y-%m-%d)"
    echo ""
    echo "Este archivo resume la estructura recomendada para la serie completa de videos/raps."
    echo ""
    echo "## Estructura general recomendada de la serie"
    echo ""
    echo "1. Intro general del proyecto + CORO de la serie"
    echo "2. Módulos 01 al 09 (cada uno con su CORO + 4-5 ESTROFAS)"
    echo "3. OUTRO final + llamada a acción (clonar repo + practicar)"
    echo ""

    echo "## Resumen por módulo"
    echo ""

    for skeleton in "$OUTPUT_DIR"/0*-*.md; do
      if [ -f "$skeleton" ]; then
        module=$(basename "$skeleton" .md)
        echo "### $module"
        grep -E "^### (CORO|ESTROFA|OUTRO)" "$skeleton" | head -6
        echo ""
      fi
    done

    echo "## Recomendación de producción"
    echo "- Graba todos los demos con \`--video\` para consistencia de ritmo."
    echo "- Usa los prompts de la carpeta suno-prompts/ directamente en Suno."
    echo "- Mantén el orden actual de los módulos."
  } > "$MASTER_FILE"

  echo "Master generado: $MASTER_FILE"
}

# === MAIN ===
if [ $# -eq 0 ] || [ "$1" = "--all" ]; then
  echo "=== Generando esqueletos completos para todos los módulos ==="
  for demo in "$PROJECT_ROOT"/labs/*/demo.sh; do
    generate_skeleton "$demo"
  done
  echo ""
  generate_master
  echo ""
  echo "✅ Todo generado en: $OUTPUT_DIR/"
  echo "✅ Prompts de Suno en: $SUNO_DIR/"
else
  generate_skeleton "$1"
fi