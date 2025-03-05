$MOD_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path

$TARGET_DIR = Get-ChildItem -Path "$env:USERPROFILE\AppData\Roaming\Balatro\Mods" -Directory -Recurse -ErrorAction SilentlyContinue

if (-not $TARGET_DIR) {
    Write-Host "Target directory not found. Please ensure Balatro is installed aswell as Lovely and SMODS."
    exit 1
}

Write-Host "Installing mod..."
Copy-Item -Path "$MOD_DIR\*" -Destination $TARGET_DIR.FullName -Recurse -Force

Write-Host "Mod installed successfully!"