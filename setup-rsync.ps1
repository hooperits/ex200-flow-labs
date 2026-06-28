# PowerShell Setup Script for rsync on Windows Host
# This script automatically installs cwRsync via Microsoft Winget (the native Windows Package Manager)

Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host "         Instalador Automático de rsync para Windows (Winget)" -ForegroundColor Cyan
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Check if rsync is already in PATH
$rsyncCmd = Get-Command rsync -ErrorAction SilentlyContinue
if ($rsyncCmd) {
    Write-Host "[✓] rsync ya está configurado en tu sistema en: $($rsyncCmd.Source)" -ForegroundColor Green
    Exit 0
}

# 2. Check if winget is available
$wingetCmd = Get-Command winget -ErrorAction SilentlyContinue
if (-not $wingetCmd) {
    Write-Host "[Error] winget (Windows Package Manager) no está disponible en tu sistema." -ForegroundColor Red
    Write-Host "Por favor, actualiza tu Windows o instala el App Installer desde la Microsoft Store." -ForegroundColor Yellow
    Exit 1
}

# 3. Install cwRsync via winget
Write-Host "Instalando cwRsync Client a través de winget..." -ForegroundColor Yellow
Write-Host "Comando: winget install Itefix.cwRsync.Client --accept-source-agreements --accept-package-agreements" -ForegroundColor Gray

# Run winget installation
Start-Process winget -ArgumentList "install Itefix.cwRsync.Client --accept-source-agreements --accept-package-agreements" -NoNewWindow -Wait

# 4. Verify installation and check PATH
$commonPaths = @(
    "C:\Program Files\cwRsync\bin",
    "C:\Program Files (x86)\cwRsync\bin"
)

$installedPath = $null
foreach ($path in $commonPaths) {
    if (Test-Path "$path\rsync.exe") {
        $installedPath = $path
        break
    }
}

if ($installedPath) {
    Write-Host ""
    Write-Host "[✓] cwRsync Client se instaló correctamente en: $installedPath" -ForegroundColor Green
    
    # Check if the path is in the environment
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$installedPath*") {
        Write-Host "Agregando $installedPath a tu variable de entorno PATH de usuario..." -ForegroundColor Yellow
        $newPath = $currentPath + ";" + $installedPath
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        Write-Host "[✓] PATH actualizado de forma permanente." -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "======================================================================" -ForegroundColor Green
    Write-Host " ¡LISTO! Por favor, CIERRA esta terminal y abre una NUEVA de PowerShell" -ForegroundColor Green
    Write-Host " para que los cambios surtan efecto y puedas usar 'vagrant up'." -ForegroundColor Green
    Write-Host "======================================================================" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "[Error] La instalación de winget terminó, pero no se encontró rsync.exe en los directorios estándar." -ForegroundColor Red
    Write-Host "Por favor, reinicia la terminal e intenta ejecutar 'rsync --version' manualmente." -ForegroundColor Yellow
}
