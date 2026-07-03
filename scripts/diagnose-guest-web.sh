#!/bin/bash
# Diagnóstico guest: IP DHCP, firewalld, servicios web EX200 (8080/7681)

set -uo pipefail

EX200_STATE_DIR="/var/lib/ex200"
GUEST_IP_FILE="${EX200_STATE_DIR}/guest-ip"
GUEST_IFACE_FILE="${EX200_STATE_DIR}/guest-iface"
FIX_MODE=false
FAILURES=0

usage() {
  echo "Uso: $0 [--fix]"
  echo "  --fix  Reaplica reglas firewalld usando GUEST_IP persistida"
  exit 0
}

pass() { echo "[OK]   $*"; }
fail() { echo "[FAIL] $*"; FAILURES=$((FAILURES + 1)); }
warn() { echo "[WARN] $*"; }

get_live_ip() {
  local iface="${1:-}"
  if [[ -z "$iface" ]]; then
    iface=$(ip -4 route show default 2>/dev/null | awk '{print $5; exit}')
  fi
  if [[ -n "$iface" ]]; then
    ip -4 -o addr show dev "$iface" scope global 2>/dev/null \
      | awk '{print $4}' | cut -d/ -f1 | head -1
  fi
}

apply_firewall_fix() {
  local guest_ip iface
  guest_ip=$(cat "$GUEST_IP_FILE" 2>/dev/null || get_live_ip "")
  iface=$(cat "$GUEST_IFACE_FILE" 2>/dev/null || ip -4 route show default | awk '{print $5; exit}')

  if [[ -z "$guest_ip" ]]; then
    echo "ERROR: No hay GUEST_IP para --fix" >&2
    return 1
  fi

  export GUEST_IP="$guest_ip"
  export IFACE="$iface"

  if systemctl is-active --quiet firewalld; then
    [[ -n "$iface" ]] && firewall-cmd --permanent --zone=public --change-interface="$iface" 2>/dev/null || true
    firewall-cmd --permanent --zone=public --add-port=8080/tcp 2>/dev/null || true
    firewall-cmd --permanent --zone=public --add-port=7681/tcp 2>/dev/null || true
    firewall-cmd --permanent --zone=public \
      --add-rich-rule="rule family=ipv4 destination address=${guest_ip} port port=8080 protocol=tcp accept" \
      2>/dev/null || true
    firewall-cmd --permanent --zone=public \
      --add-rich-rule="rule family=ipv4 destination address=${guest_ip} port port=7681 protocol=tcp accept" \
      2>/dev/null || true
    firewall-cmd --reload
    systemctl restart ttyd.service ex200-guide.service 2>/dev/null || true
    echo "Firewall y servicios reaplicados para ${guest_ip}"
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --fix) FIX_MODE=true; shift ;;
    -h|--help) usage ;;
    *) echo "Opción desconocida: $1" >&2; exit 2 ;;
  esac
done

if $FIX_MODE; then
  apply_firewall_fix
  exit 0
fi

echo "=== Diagnóstico guest EX200 (web platform) ==="

# 1. IP persistida vs IP en vivo
if [[ -f "$GUEST_IP_FILE" ]]; then
  stored_ip=$(cat "$GUEST_IP_FILE")
  pass "IP persistida: ${stored_ip}"
else
  fail "No existe ${GUEST_IP_FILE} (ejecuta vagrant provision)"
  stored_ip=""
fi

iface=""
[[ -f "$GUEST_IFACE_FILE" ]] && iface=$(cat "$GUEST_IFACE_FILE")
live_ip=$(get_live_ip "$iface")

if [[ -n "$live_ip" ]]; then
  pass "IP en vivo (${iface:-default}): ${live_ip}"
else
  fail "No hay IPv4 global en la interfaz de ruta por defecto"
fi

if [[ -n "$stored_ip" && -n "$live_ip" && "$stored_ip" != "$live_ip" ]]; then
  warn "IP persistida (${stored_ip}) difiere de IP en vivo (${live_ip}); considera vagrant provision"
fi

GUEST_IP="${live_ip:-$stored_ip}"

# 2. firewalld
if systemctl is-active --quiet firewalld; then
  pass "firewalld activo"
  fw_ports=$(firewall-cmd --zone=public --list-ports 2>/dev/null || true)
  echo "$fw_ports" | grep -q '8080/tcp' && pass "Puerto 8080/tcp abierto" || fail "Puerto 8080/tcp NO abierto en firewalld"
  echo "$fw_ports" | grep -q '7681/tcp' && pass "Puerto 7681/tcp abierto" || fail "Puerto 7681/tcp NO abierto en firewalld"

  if [[ -n "$GUEST_IP" ]]; then
    fw_rules=$(firewall-cmd --zone=public --list-rich-rules 2>/dev/null || true)
    echo "$fw_rules" | grep -q "$GUEST_IP" && pass "Rich rules contienen ${GUEST_IP}" \
      || fail "Rich rules sin destination address=${GUEST_IP}"
  fi
else
  warn "firewalld inactivo (puertos no filtrados por firewalld)"
fi

# 3. Servicios systemd
for svc in ttyd ex200-guide; do
  if systemctl is-active --quiet "${svc}.service"; then
    pass "Servicio ${svc}.service activo"
  else
    fail "Servicio ${svc}.service inactivo"
  fi
done

# 4. Listeners
if ss -tlnp 2>/dev/null | grep -q ':8080 '; then
  pass "Proceso escuchando en :8080"
else
  fail "Nada escuchando en :8080"
fi

if ss -tlnp 2>/dev/null | grep -q ':7681 '; then
  pass "Proceso escuchando en :7681"
else
  fail "Nada escuchando en :7681"
fi

# 5. HTTP local
if curl -sf --max-time 5 http://127.0.0.1:8080/ >/dev/null 2>&1; then
  pass "HTTP 8080 responde en localhost"
else
  fail "HTTP 8080 no responde en localhost"
fi

if curl -sf --max-time 5 -o /dev/null http://127.0.0.1:7681/ 2>&1; then
  pass "HTTP 7681 responde en localhost"
else
  # ttyd puede devolver código no-2xx en HEAD; comprobar conexión TCP
  if ss -tlnp | grep -q ':7681 '; then
    pass "Puerto 7681 acepta conexiones"
  else
    fail "HTTP 7681 no accesible"
  fi
fi

# 6. SELinux (informativo)
if command -v getenforce &>/dev/null; then
  warn "SELinux: $(getenforce)"
fi

echo ""
if [[ $FAILURES -eq 0 ]]; then
  echo "RESULTADO: TODO OK"
  [[ -n "$GUEST_IP" ]] && echo "Acceso desde el host: http://${GUEST_IP}:8080/?lab=01"
  exit 0
else
  echo "RESULTADO: ${FAILURES} fallo(s). Prueba: $0 --fix  o  vagrant provision"
  exit 1
fi