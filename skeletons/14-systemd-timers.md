# Esqueleto Video / Letras - 14-systemd-timers
# Generado desde: labs/14-systemd-timers/demo.sh
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

[00:00 - 00:48] - ESTROFA 1: 1. Crear una Unidad Timer

- **Crea servicio de ejemplo**
  ```
  echo '[Unit]
  ```

- **Crea timer**
  ```
  echo '[Unit]
  ```

- **Habilita timer**
  ```
  sudo systemctl enable --now rhcsa-timer.timer
  ```

- **Lista timers**
  ```
  systemctl list-timers | grep rhcsa || echo 'Verificación'
  ```

[00:48 - 01:24] - ESTROFA 2: 2. Probar el Timer

- **Verifica activo**
  ```
  systemctl is-active rhcsa-timer.timer
  ```

- **Muestra status**
  ```
  systemctl status rhcsa-timer.timer | head -5
  ```

- **Lista timers**
  ```
  systemctl list-timers | grep rhcsa || echo 'Verificación'
  ```

[01:24 - 01:54] - ESTROFA 3: 3. Configurar Servicio Asociado

- **Verifica servicio**
  ```
  systemctl status rhcsa-timer.service | head -3 || true
  ```

[01:54 - 02:24] - ESTROFA 4: 4. Validar

- **Lista timers activos**
  ```
  systemctl list-timers --all | head -3
  ```

- **Deshabilita**
  ```
  sudo systemctl disable --now rhcsa-timer.timer
  ```

[02:24 - 02:24] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~2 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Crear una Unidad Timer
- Crea servicio de ejemplo → echo '[Unit]
- Crea timer → echo '[Unit]
- Habilita timer → sudo systemctl enable --now rhcsa-timer.timer
- Lista timers → systemctl list-timers | grep rhcsa || echo 'Verificación'
ESTROFA: 2. Probar el Timer
- Verifica activo → systemctl is-active rhcsa-timer.timer
- Muestra status → systemctl status rhcsa-timer.timer | head -5
- Lista timers → systemctl list-timers | grep rhcsa || echo 'Verificación'
ESTROFA: 3. Configurar Servicio Asociado
- Verifica servicio → systemctl status rhcsa-timer.service | head -3 || true
ESTROFA: 4. Validar
- Lista timers activos → systemctl list-timers --all | head -3
- Deshabilita → sudo systemctl disable --now rhcsa-timer.timer

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
