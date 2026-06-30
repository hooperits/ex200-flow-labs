# Esqueleto Video / Letras - 15-troubleshooting
# Generado desde: labs/15-troubleshooting/demo.sh
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

[00:00 - 00:36] - ESTROFA 1: 1. Diagnosticar Servicio Fallido

- **Simula servicio fallido**
  ```
  echo 'Simulando servicio roto' 
  ```

- **Usa journalctl para diagnosticar**
  ```
  journalctl -u sshd --no-pager | tail -5 || true
  ```

- **Status servicio**
  ```
  systemctl status sshd | head -5
  ```

[00:36 - 01:24] - ESTROFA 2: 2. Resolver Permisos

- **Crea archivo con mal permiso**
  ```
  touch /tmp/broken_perm.txt && chmod 000 /tmp/broken_perm.txt
  ```

- **Diagnostica**
  ```
  ls -l /tmp/broken_perm.txt
  ```

- **Arregla**
  ```
  chmod 644 /tmp/broken_perm.txt
  ```

- **Verifica**
  ```
  ls -l /tmp/broken_perm.txt
  ```

[01:24 - 02:12] - ESTROFA 3: 3. Network Troubleshooting

- **Muestra IP**
  ```
  ip addr show | head -5
  ```

- **Prueba conectividad**
  ```
  ping -c 1 127.0.0.1 || true
  ```

- **Puertos**
  ```
  ss -tuln | head -3
  ```

- **Conexiones activas**
  ```
  ss -tuln | grep LISTEN | head -2
  ```

[02:12 - 02:42] - ESTROFA 4: 4. Validar y Documentar

- **Genera log de diagnóstico**
  ```
  echo 'Diagnóstico completado' > /tmp/troubleshoot.log
  ```

- **Verifica**
  ```
  cat /tmp/troubleshoot.log
  ```

[02:42 - 02:42] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~2 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Diagnosticar Servicio Fallido
- Simula servicio fallido → echo 'Simulando servicio roto' 
- Usa journalctl para diagnosticar → journalctl -u sshd --no-pager | tail -5 || true
- Status servicio → systemctl status sshd | head -5
ESTROFA: 2. Resolver Permisos
- Crea archivo con mal permiso → touch /tmp/broken_perm.txt && chmod 000 /tmp/broken_perm.txt
- Diagnostica → ls -l /tmp/broken_perm.txt
- Arregla → chmod 644 /tmp/broken_perm.txt
- Verifica → ls -l /tmp/broken_perm.txt
ESTROFA: 3. Network Troubleshooting
- Muestra IP → ip addr show | head -5
- Prueba conectividad → ping -c 1 127.0.0.1 || true
- Puertos → ss -tuln | head -3
- Conexiones activas → ss -tuln | grep LISTEN | head -2
ESTROFA: 4. Validar y Documentar
- Genera log de diagnóstico → echo 'Diagnóstico completado' > /tmp/troubleshoot.log
- Verifica → cat /tmp/troubleshoot.log

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
