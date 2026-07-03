# Diagnóstico Hyper-V: switch DHCP, IP guest, firewall, servicios web EX200.
# Uso: .\scripts\diagnose-hyperv.ps1 [-VmName RHCSA-EX200-flow-labs]

param(
    [string]$VmName = "RHCSA-EX200-flow-labs"
)

$ErrorActionPreference = "Continue"
$Failures = 0

function Test-Check {
    param([bool]$Ok, [string]$Message)
    if ($Ok) { Write-Host "[OK]   $Message" -ForegroundColor Green }
    else { Write-Host "[FAIL] $Message" -ForegroundColor Red; $script:Failures++ }
}

function Get-GuestIpFromSsh {
    try {
        Push-Location $PSScriptRoot\..
        $raw = vagrant ssh -c "cat /var/lib/ex200/guest-ip 2>/dev/null" 2>&1
        Pop-Location
        if ($LASTEXITCODE -eq 0 -and $raw) {
            $ip = ($raw | Out-String).Trim() -replace "`r`n", ""
            if ($ip -match '^\d{1,3}(\.\d{1,3}){3}$') { return $ip }
        }
    } catch { }
    return $null
}

Write-Host "=== Diagnóstico Hyper-V EX200 ===" -ForegroundColor Cyan
Write-Host ""

# Hyper-V disponible
$hv = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V 2>$null
if ($hv -and $hv.State -eq 'Enabled') {
    Test-Check $true "Hyper-V habilitado"
} else {
    Test-Check $false "Hyper-V no habilitado"
}

# VM estado
$vm = $null
try {
    $vm = Get-VM -Name $VmName -ErrorAction Stop
    Test-Check ($vm.State -eq 'Running') "VM ${VmName} en ejecución (estado: $($vm.State))"
} catch {
    Test-Check $false "VM ${VmName} no encontrada: $_"
}

# Switch e IP desde Hyper-V
$hvIp = $null
$switchName = $null
if ($vm) {
    try {
        $adapter = Get-VMNetworkAdapter -VMName $VmName
        $switchName = $adapter.SwitchName
        Test-Check ($null -ne $switchName) "Switch virtual: ${switchName}"
        $hvIp = ($adapter.IPAddresses | Where-Object {
            $_ -match '^\d{1,3}(\.\d{1,3}){3}$' -and $_ -notmatch '^169\.254\.'
        } | Select-Object -First 1)
        if ($hvIp) {
            Test-Check $true "IP DHCP (Hyper-V): ${hvIp}"
        } else {
            Test-Check $false "Sin IPv4 en adaptador de red (¿DHCP pendiente?)"
        }
    } catch {
        Test-Check $false "Error leyendo adaptador de red: $_"
    }
}

# IP persistida en guest
$guestIp = Get-GuestIpFromSsh
if ($guestIp) {
    Test-Check $true "IP persistida (guest): ${guestIp}"
} else {
    Test-Check $false "No se leyó /var/lib/ex200/guest-ip (¿provision incompleto?)"
}

if ($hvIp -and $guestIp -and $hvIp -ne $guestIp) {
    Write-Host "[WARN] IP Hyper-V (${hvIp}) != IP guest (${guestIp})" -ForegroundColor Yellow
}

$targetIp = if ($guestIp) { $guestIp } elseif ($hvIp) { $hvIp } else { $null }

# Portproxy
$proxy = netsh interface portproxy show v4tov4 2>$null | Out-String
if ($targetIp) {
    $proxyOk = ($proxy -match "8080" -and $proxy -match $targetIp)
    Test-Check $proxyOk "Portproxy apunta a ${targetIp} (puertos 8080/7681)"
} else {
    Test-Check $false "No se pudo validar portproxy (sin IP objetivo)"
}

# Conectividad desde host
if ($targetIp) {
    foreach ($port in @(22, 8080, 7681)) {
        $r = Test-NetConnection -ComputerName $targetIp -Port $port -WarningAction SilentlyContinue
        Test-Check $r.TcpTestSucceeded "Test-NetConnection ${targetIp}:${port}"
    }
}

# Diagnóstico dentro del guest
Write-Host ""
Write-Host "--- Diagnóstico guest (ex200-diagnose) ---" -ForegroundColor Cyan
try {
    Push-Location $PSScriptRoot\..
    vagrant ssh -c "sudo /usr/local/bin/ex200-diagnose 2>/dev/null || /usr/local/bin/ex200-diagnose" 2>&1
    $guestExit = $LASTEXITCODE
    Pop-Location
    Test-Check ($guestExit -eq 0) "Script ex200-diagnose en guest"
} catch {
    Test-Check $false "No se pudo ejecutar ex200-diagnose: $_"
}

Write-Host ""
if ($Failures -eq 0) {
    Write-Host "RESULTADO: TODO OK" -ForegroundColor Green
    if ($targetIp) {
        Write-Host "Abre: http://${targetIp}:8080/?lab=01"
    }
    exit 0
} else {
    Write-Host "RESULTADO: $Failures fallo(s)" -ForegroundColor Red
    Write-Host "Sugerencias:"
    Write-Host "  vagrant provision"
    Write-Host "  .\scripts\configure-hyperv-portproxy.ps1"
    Write-Host "  vagrant ssh -c 'sudo /usr/local/bin/ex200-diagnose --fix'"
    exit 1
}