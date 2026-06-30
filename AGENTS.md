# Project Notes (Internal)

## Content Creation Strategy (IMPORTANT)

This repository is **public and educational**.

The primary reason `demo.sh` scripts exist in every lab is **video production**:
- Record clean, well-paced terminal sessions from `demo.sh`
- Match with timed Spanish RAP lyrics (Eminem-style)
- Generate audio with Suno AI
- Upload to YouTube channel for views + subs
- Funnel viewers to clone this repo on GitHub (stars, forks, followers)

**Strict rule**:
- Do NOT mention video production, Suno, RAP, YouTube, content strategy, or lyrics in README.md, public docs, or any file that gets published with the repo.
- Keep the repo looking like a pure, professional RHCSA practice platform.
- All YouTube/lyrics work happens in the sibling folder: `~/proys/RHCSA-EX200-lyrics/`
- YouTube API + automation lives in: `~/proys/hooperits8/`

When making improvements (especially to demo.sh, new labs, or command accuracy):
- Changes will require re-examining and updating the corresponding .txt lyrics and Suno prompts.
- Prefer adding video-friendly flags to demo.sh (`--fast`, `--video`, configurable pacing) instead of changing the default student experience.
- Maintain 1:1 section alignment where possible between demo sections and lyric "ESTROFAS".

## Growth Goals (dual funnel)
1. YouTube: High-retention educational RAP videos → views + subscriptions.
2. GitHub: Videos drive people to `git clone` + star the repo.

All public-facing text must stay 100% focused on helping students pass the RHCSA EX200.

> **⚠️ BEFORE ANY EDITS: Read "ANTI-LOOP RULE (MANDATORY)" below.**  
> It governs all work on generators, prompts, and repetitive changes. Violating read-first + run-and-show is a process failure.

## Reglas de Calidad Educativa

Estas reglas definen la calidad requerida para el contenido educativo.

Tienen igual prioridad que las necesidades de producción de video.

Cuando un cambio viole una regla para favorecer la producción de video:
- Pausa
- Documenta el conflicto
- Consulta antes de continuar

### Reglas

1. Mapeo a objetivos oficiales
   Toda tarea debe mapearse explícitamente a uno o más objetivos oficiales del examen RHCSA EX200.

2. Reto real y verificable
   Los estudiantes deben poder completar las tareas con comandos reales. La simulación (echo) solo cuando sea necesario y justificado.

3. Verificadores confiables
   verify.sh debe validar el estado deseado real. Debe ser difícil pasar sin completar correctamente la tarea.

4. Persistencia real
   Las configuraciones solicitadas deben sobrevivir a un reinicio (salvo que el objetivo del lab indique explícitamente lo contrario).

5. Demo como apoyo
   El estudiante debe poder completar el reto usando solo instructions.md + hints.md. demo.sh es suplementario.

6. Reset limpio y repeatable
   reset.sh debe devolver el entorno a un estado limpio y consistente.

7. Trucos de producción
   Las decisiones específicas de video (ritmo, estructura, etc.) no deben degradar la experiencia educativa por defecto.

## Checklist Post-Tarea

Revisa este checklist después de completar cada tarea o cambio significativo.

Si algún ítem se compromete por razones de producción de video: pausa y consulta.

- [ ] Mapea a objetivo(s) oficial(es) EX200
- [ ] Se usan comandos reales (simulación mínima)
- [ ] verify.sh chequea el estado real de forma confiable
- [ ] La configuración sobrevive a reboot
- [ ] El reto se puede completar sin depender de demo.sh
- [ ] reset.sh deja estado limpio y repeatable
- [ ] Ninguna optimización de video degrada la experiencia educativa por defecto

Documenta cualquier conflicto de regla antes de continuar.

## ANTI-LOOP RULE (MANDATORY — STRICTLY ENFORCED)

**Scope**: Applies to every AI session, agent, and contributor making changes via tools in this repository.

**Root Cause This Rule Addresses**:
Repeated micro-edits (especially synonym swapping inside long static strings such as Suno prompts) without re-reading the exact current file content and without executing + reviewing actual generated output. This creates unproductive loops, burns context, and produces little real progress.

### Core Mandates

1. **Read-First Discipline (Non-Negotiable)**
   - Before proposing or executing **any** edit (`search_replace`, `write`, or manual change), you **MUST** first call `read_file` (preferred) or a targeted `grep` with sufficient context on the exact section you intend to modify.
   - Never edit from stale memory or previous conversation turns. Re-read the live content every time.

2. **Hard Iteration Limit on Micro-Changes**
   - Maximum **2 consecutive** rephrasings / small wording tweaks on the *same logical string, phrase, or section*.
   - On the 3rd attempt targeting the same thing:
     - **STOP** micro-editing.
     - Immediately run the affected tool/generator/script and present the **real output**.
     - Or switch to a structural change (see below).
     - Or explicitly ask the user for direction with concrete options.

3. **Mandatory Output Verification for Generators**
   - Any modification to code that produces artifacts (especially `scripts/generate-video-skeleton.sh`, Suno prompts, skeletons, templates, MASTER files, etc.) **requires**:
     1. Perform the edit.
     2. Run `./scripts/generate-video-skeleton.sh --all` (or targeted module).
     3. Use `read_file` to inspect at least the key generated files (`skeletons/...` and `skeletons/suno-prompts/...`).
     4. Include relevant excerpts of the **newly generated content** in your reasoning.
   - Never declare "prompt improved" without showing the actual produced prompt.

4. **Loop Detection Signals — Self-Interrupt Required**
   If any of these occur, you **must** pause editing the current target and change approach:
   - 3+ `search_replace` attempts on the same (or nearly identical) string within a short period.
   - Repeated "try another wording" / "make it more X" on a single line without new diagnostic information.
   - `search_replace` failures because the `old_string` no longer matches (classic sign you did not re-read).
   - Editing the same 1-3 lines across many turns while the rest of the file is untouched.
   - Feeling the urge to do "one more tiny tweak" before running the script.

5. **Preferred Anti-Loop Techniques (Use These Instead)**
   - **Structural changes over cosmetic**: Extract magic strings into variables, here-documents, or a data file. Add parameters or a `--style` flag. Improve the *generator logic* rather than hand-tuning the output string.
   - Make prompts data-driven when they become long and contentious.
   - After any change that touches output: run the generator, read the result, `git diff`, then decide the *next high-value* improvement.
   - Use `todo_write` (when appropriate) to break large iterations into visible checkpoints.
   - For prompt/lyrics style work: make one clear directional change, generate, review the full artifact, then iterate at the architectural level if needed.

6. **Session Hygiene & Documentation**
   - When you make a change, briefly note *why* (what problem it solves) near the edit or in your response.
   - Prefer "run + show output" cycles over "edit + hope".
   - If stuck for more than 2-3 micro attempts, step back: read the entire relevant function, consider a bigger refactor, or present 2-3 alternative strategies to the user.
   - Use `run_terminal_command` proactively to verify.

### Quick Decision Tree When Tempted to Edit a String Again
```
Did I just re-read the exact current text?          → No → READ FIRST
Is this the 3rd+ wording attempt on same target?    → Yes → RUN GENERATOR + SHOW OUTPUT
Am I only changing adjectives/synonyms?            → Yes → Extract to variable or add parameter instead
Have I shown generated output since last edit?      → No → Run script before next replace
```

**Enforcement**: This rule has the same weight as the Educational Quality Rules. Violating the read-first or run-and-show discipline is considered a process failure.

This rule exists so we spend tokens on real improvements (structure, features, correctness, new labs) instead of prompt synonym ping-pong.

## Política de Idioma (Público objetivo: hablantes de español)

- Narrativa pública (README, instructions.md, hints.md, comentarios en scripts, mensajes de salida): español.
- Comandos, términos técnicos (ej. systemctl, fstab, rd.break, LVM, VDO), nombres de archivos, código: inglés (según requiere el examen RHCSA).
- Documentos internos (AGENTS.md, ROADMAP.md, auditorías): pueden usar inglés para eficiencia del equipo, pero respetar la narrativa en español para cualquier contenido público.
- Siempre: el público objetivo son hablantes de español que se preparan para el examen (en inglés).

- [ ] Maps to official EX200 objective(s)
- [ ] Real commands used (minimal simulation)
- [ ] verify.sh checks actual state reliably
- [ ] Configuration survives reboot
- [ ] Task completable without demo.sh
- [ ] reset.sh leaves clean repeatable state
- [ ] No video optimization degrades default student experience

Document any rule conflict before continuing.

## Educational Quality Rules

These rules define what "high quality educational material" means in this project. They have equal weight with video production needs.

When a decision would compromise any of these rules in favor of easier video production, **pause** and consult before proceeding.

### The Rules

1. **Mapeo a objetivos oficiales**  
   Toda tarea nueva o modificada debe estar explícitamente ligada a uno o más objetivos oficiales del examen RHCSA EX200 actual.

2. **El reto es real y verificable**  
   El estudiante debe poder resolver el reto usando comandos reales (o lo más cercanos posible). El uso de simulaciones (`echo "comando"`) debe ser la excepción y justificarse.

3. **Los verificadores son confiables**  
   `verify.sh` debe comprobar el estado real deseado. Debe ser difícil pasar el verificador sin haber hecho correctamente el reto.

4. **Persistencia real**  
   Las configuraciones solicitadas deben sobrevivir a un reinicio (salvo que el objetivo explícito del lab sea distinto).

5. **El demo es apoyo, no muleta**  
   Un estudiante debe poder completar el reto con solo `instructions.md` + `hints.md`. El `demo.sh` es para comprensión y producción de contenido, no para ocultar complejidad.

6. **Reset limpio y repeatable**  
   `reset.sh` debe dejar el entorno en un estado consistente y limpio para que el reto pueda repetirse sin residuos.

7. **Claridad sobre trucos de producción**  
   Cualquier decisión tomada principalmente para facilitar grabación de video (pacing, secciones, etc.) no debe degradar la experiencia educativa por defecto.

## Post-Task Educational Quality Checklist

Use this checklist at the end of every significant task (new lab, major change to demo/verify/instructions, etc.).

**Review Process:**
- Go through the checklist.
- If any item is at risk or would be compromised to benefit video production → **Stop and consult** before continuing.

| # | Rule | Checklist Item | Status | Notes / Risk |
|---|------|----------------|--------|--------------|
| 1 | Mapeo a objetivos | ¿La tarea está claramente mapeada a objetivos oficiales del EX200? | [ ] | |
| 2 | Reto real | ¿Se usan comandos reales en lugar de simulaciones excesivas? | [ ] | |
| 3 | Verificadores confiables | ¿El verify.sh comprueba el estado real deseado de forma robusta? | [ ] | |
| 4 | Persistencia | ¿Las configuraciones sobreviven a reboot? | [ ] | |
| 5 | Demo como apoyo | ¿El reto se puede completar sin depender del demo.sh? | [ ] | |
| 6 | Reset | ¿El reset.sh deja el entorno limpio y repeatable? | [ ] | |
| 7 | Trucos de producción | ¿Alguna decisión de video afecta negativamente la experiencia educativa por defecto? | [ ] | |

**If any item fails or is at risk:**
1. Document the conflict.
2. Pause.
3. Present the situation with options before proceeding.

This checklist ensures we maintain equal strategic weight between educational quality and video production needs.
