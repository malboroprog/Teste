# scripts/build-installer-portable.ps1
$tools = Join-Path (Get-Location) "tools\nsis"
New-Item -ItemType Directory -Path $tools -Force | Out-Null
$zipUrl = "https://prdownloads.sourceforge.net/nsis/nsis-3.08.1-portable.zip"
$zipPath = Join-Path $tools "nsis.zip"
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $tools -Force
$makensis = Get-ChildItem -Path $tools -Recurse -Filter makensis.exe | Select-Object -First 1
if (-not $makensis) { Write-Error "makensis.exe não encontrado em $tools"; exit 1 }
& $makensis.FullName "installer\myapp_installer.nsi"
