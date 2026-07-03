# Configura netsh portproxy hacia la IP DHCP real de la VM EX200.
# Uso: .\scripts\configure-hyperv-portproxy.ps1 [-VmName RHCSA-EX200-flow-labs]

param(
    [string]$VmName = "RHCSA-EX200-flow-labs"
)

$ErrorActionPreference = "Stop"

function Get-GuestIpFromSsh {
    $raw = vagrant ssh -c "cat /var/lib/ex200/guest-ip 2>/dev/null || true" 2>$null
    if ($raw) {
        $ip = ($raw -replace "`r`n", "" -replace "`n", "").Trim()
        if ($ip -match '^\d{1,3}(\.\d{1,3}){3}$') { return $ip }
    }
    return $null
}

function Get-GuestIpFromHyperV {
    param([string]$Name)
    try {
        $adapter = Get-VMNetworkAdapter -VMName $Name -ErrorAction Stop
        $ips = $adapter.IPAddresses | Where-Object { $_ -match '^\d{1,3}(\.\d{1,3}){3}$' -and $_ -notmatch '^169\.254\.' }
        if ($ips) { return $ips[0] }
    } catch {
        Write-Warning "Get-VMNetworkAdapter: $_"
    }
    return $null
}

if ($env:OS -ne 'Windows_NT') {
    Write-Host "Omitiendo portproxy (no es Windows)."
    exit 0
}

$guestIp = Get-GuestIpFromSsh
if (-not $guestIp) {
    $guestIp = Get-GuestIpFromHyperV -Name $VmName
}

if (-not $guestIp) {
    Write-Warning "No se pudo obtener GUEST_IP. Ejecuta vagrant provision y reintenta."
    exit 1
}

foreach ($port in @(8080, 7681)) {
    netsh interface portproxy delete v4tov4 listenport=$port listenaddress=127.0.0.1 2>$null | Out-Null
    netsh interface portproxy delete v4tov4 listenport=$port 2>$null | Out-Null
    netsh interface portproxy add v4tov4 listenport=$port listenaddress=127.0.0.1 `
        connectport=$port connectaddress=$guestIp | Out-Null
}

Write-Host "Portproxy configurado: localhost:8080 y :7681 -> ${guestIp}"
Write-Host "  http://localhost:8080/?lab=01"
Write-Host "  http://${guestIp}:8080/?lab=01"