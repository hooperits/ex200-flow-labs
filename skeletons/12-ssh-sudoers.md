# Esqueleto Video / Letras - 12-ssh-sudoers
# Generado desde: labs/12-ssh-sudoers/demo.sh
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

[00:00 - 00:48] - ESTROFA 1: 1. Configurar Autenticación por Claves SSH

- **Generamos par de claves**
  ```
  ssh-keygen -t rsa -f /tmp/id_rsa_test -N '' -q
  ```

- **Creamos directorio .ssh**
  ```
  mkdir -p ~/.ssh && chmod 700 ~/.ssh
  ```

- **Copiamos clave pública**
  ```
  cat /tmp/id_rsa_test.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
  ```

- **Verificamos**
  ```
  ls -l ~/.ssh/authorized_keys
  ```

[00:48 - 01:24] - ESTROFA 2: 2. Configurar sudoers

- **Creamos sudoers.d para grupo**
  ```
  echo '%wheel ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/wheel-nopasswd
  ```

- **Verificamos sintaxis**
  ```
  sudo visudo -c -f /etc/sudoers.d/wheel-nopasswd || echo 'Verificación'
  ```

- **Prueba (simulada)**
  ```
  sudo -l | head -3 || true
  ```

[01:24 - 02:12] - ESTROFA 3: 3. Restringir Acceso SSH

- **Backup sshd_config**
  ```
  sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
  ```

- **Deshabilitamos root login**
  ```
  sudo sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
  ```

- **Reiniciamos sshd**
  ```
  sudo systemctl restart sshd || echo 'Simulado'
  ```

- **Verificamos config**
  ```
  grep PermitRootLogin /etc/ssh/sshd_config
  ```

[02:12 - 02:42] - ESTROFA 4: 4. Probar Config

- **Verificamos usuarios**
  ```
  id vagrant
  ```

- **Prueba sudo (simulada)**
  ```
  sudo -u vagrant echo 'test' || true
  ```

[02:42 - 02:42] - OUTRO / CIERRE

- Recordatorio final + llamada a practicar el reto

Tiempo total estimado del video: ~2 minutos

## Prompt listo para Suno AI (copia y pega)
Genera un rap técnico y agresivo en español con un flujo chopper de velocidad extrema, rimas multisilábicas densas e intrincadas, dicción impecable y cristalina incluso a máxima velocidad, y un estilo de entrega preciso, dominante y cargado de alta complejidad rítmica.
Estructura: CORO + 4-5 ESTROFAS + OUTRO.
Incluye estos conceptos clave con sus comandos:

ESTROFA: 1. Configurar Autenticación por Claves SSH
- Generamos par de claves → ssh-keygen -t rsa -f /tmp/id_rsa_test -N '' -q
- Creamos directorio .ssh → mkdir -p ~/.ssh && chmod 700 ~/.ssh
- Copiamos clave pública → cat /tmp/id_rsa_test.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
- Verificamos → ls -l ~/.ssh/authorized_keys
ESTROFA: 2. Configurar sudoers
- Creamos sudoers.d para grupo → echo '%wheel ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/wheel-nopasswd
- Verificamos sintaxis → sudo visudo -c -f /etc/sudoers.d/wheel-nopasswd || echo 'Verificación'
- Prueba (simulada) → sudo -l | head -3 || true
ESTROFA: 3. Restringir Acceso SSH
- Backup sshd_config → sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
- Deshabilitamos root login → sudo sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
- Reiniciamos sshd → sudo systemctl restart sshd || echo 'Simulado'
- Verificamos config → grep PermitRootLogin /etc/ssh/sshd_config
ESTROFA: 4. Probar Config
- Verificamos usuarios → id vagrant
- Prueba sudo (simulada) → sudo -u vagrant echo 'test' || true

Mantén los comandos técnicos en inglés. Prioriza velocidad extrema, precisión y rimas complejas.
