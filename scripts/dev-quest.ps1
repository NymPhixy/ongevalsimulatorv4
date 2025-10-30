<#
Runs adb reverse and starts the Vite dev server for Quest development.
Usage: .\scripts\dev-quest.ps1 [-adbPath "C:\platform-tools\adb.exe"]
#>

param(
    [string]$adbPath = 'adb'
)

function Find-Adb {
    try {
        $cmd = Get-Command $adbPath -ErrorAction Stop
        return $cmd.Path
    } catch {
        # fallback to common Windows install location
        $fallback = 'C:\platform-tools\adb.exe'
        if (Test-Path $fallback) { return $fallback }
        return $null
    }
}

$adb = Find-Adb
if (-not $adb) {
    Write-Error "adb not found. Install Android Platform Tools and/or provide path: .\scripts\dev-quest.ps1 -adbPath 'C:\platform-tools\adb.exe'"
    exit 1
}

Write-Host "Using adb: $adb"

# restart adb server
& $adb kill-server | Out-Null
& $adb start-server | Out-Null

# list devices
$devicesOutput = & $adb devices 2>&1
$lines = $devicesOutput -split "`n" | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }
$deviceLines = $lines | Where-Object { $_ -notmatch 'List of devices attached' }

if (-not $deviceLines) {
    Write-Error "No devices/emulators found. Make sure your Quest is connected via USB and USB debugging is allowed in the headset."
    Write-Host "Run `& $adb devices` to debug."
    exit 1
}

# check authorization and status
$authorized = $false
foreach ($l in $deviceLines) {
    if ($l -match '\s+device$') { $authorized = $true; break }
    if ($l -match '\s+unauthorized$') { Write-Error "Device is unauthorized. Accept the USB debugging prompt in the headset and re-run."; exit 1 }
}

if (-not $authorized) {
    Write-Error "No authorized device found. Output:`n$devicesOutput"
    exit 1
}

Write-Host "Connected device found. Setting reverse..."
& $adb reverse tcp:5173 tcp:5173

if ($LASTEXITCODE -ne 0) {
    Write-Warning "adb reverse failed. You can run: & $adb reverse tcp:5173 tcp:5173"
} else {
    Write-Host "Reverse created: device localhost:5173 -> PC:5173"
}

Write-Host "Starting dev server... (use Ctrl+C to stop)"
# run npm in the same session so the reverse stays active
npm run dev
