# Esqueleto Video / Letras - 13-kernel-sysctl
# Generado desde: labs/13-kernel-sysctl/demo.sh
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

[00:00 - 00:36] - ESTROFA 1: 1. Inspeccionar Parámetros del Kernel

- **Lista parámetros clave**
  ```
  sysctl -a | grep -E 'kernel|net.ipv4' | head -5
  ```

- **Muestra hostname del kernel**
  ```
  sysctl kernel.hostname
  ```

- **Lista net params**
  ```
  sysctl net.ipv4.ip_forward
  ```

[00:36 - 01:24] - ESTROFA 2: 2. Modificar Parámetros Temporalmente

- **Cambia hostname temporal**
  ```
  sudo sysctl -w kernel.hostname=testhost
  ```

- **Verifica cambio**
  ```
  sysctl kernel.hostname
  ```

- **Muestra /proc**
  ```
  cat /proc/sys/kernel/hostname
  ```

- **Restaura**
  ```
  sudo sysctl -w kernel.hostname=localhost
  ```

[01:24 - 02:00] - ESTROFA 3: 3. Hacer Cambios Persistentes

- **Añade a sysctl.d**
  ```
  echo 'net.ipv4.ip_forward = 1' | sudo tee /etc/sysctl.d/99-test.conf
  ```

- **Aplica cambios**
  ```
  sudo sysctl -p /etc/sysctl.d/99-test.conf
  ```

- **Verifica**
  ```
  sysctl net.ipv4.ip_forward
  ```

[02:00 - 02:30] - ESTROFA 4: 4. Probar sysctl

- **Usa sysctl -w para test**
  ```
  sudo sysctl -w kernel.sysrq=1
  ```

- **Verifica en /proc**
  ```
  cat /proc/sys/kernel/sysrq
  ```

[02:30 - 02:30] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~2 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Inspeccionar Parámetros del Kernel
- Lista parámetros clave → sysctl -a | grep -E 'kernel|net.ipv4' | head -5
- Muestra hostname del kernel → sysctl kernel.hostname
- Lista net params → sysctl net.ipv4.ip_forward
ESTROFA: 2. Modificar Parámetros Temporalmente
- Cambia hostname temporal → sudo sysctl -w kernel.hostname=testhost
- Verifica cambio → sysctl kernel.hostname
- Muestra /proc → cat /proc/sys/kernel/hostname
- Restaura → sudo sysctl -w kernel.hostname=localhost
ESTROFA: 3. Hacer Cambios Persistentes
- Añade a sysctl.d → echo 'net.ipv4.ip_forward = 1' | sudo tee /etc/sysctl.d/99-test.conf
- Aplica cambios → sudo sysctl -p /etc/sysctl.d/99-test.conf
- Verifica → sysctl net.ipv4.ip_forward
ESTROFA: 4. Probar sysctl
- Usa sysctl -w para test → sudo sysctl -w kernel.sysrq=1
- Verifica en /proc → cat /proc/sys/kernel/sysrq

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
