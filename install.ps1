# ── Package manager ───────────────────────────────────────
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Scoop..." -ForegroundColor Cyan
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    irm get.scoop.sh | iex
} else {
    Write-Host "Scoop already installed, skipping." -ForegroundColor Green
}

# ── Scoop tools ───────────────────────────────────────────
Write-Host "Installing tools..." -ForegroundColor Cyan
scoop bucket add extras
scoop install starship bat eza ripgrep tldr yazi fastfetch glow

# ── PowerShell modules ────────────────────────────────────
Write-Host "Installing PowerShell modules..." -ForegroundColor Cyan
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Install-Module -Name ZLocation -Repository PSGallery -Force

# ── Symlinks ──────────────────────────────────────────────
Write-Host "Creating symlinks..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path "C:\Users\$env:USERNAME\Documents\PowerShell" -Force
New-Item -ItemType SymbolicLink -Force `
    -Path "C:\Users\$env:USERNAME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" `
    -Target "C:\Users\$env:USERNAME\dotfiles\Microsoft.PowerShell_profile.ps1"
New-Item -ItemType SymbolicLink -Force `
    -Path "C:\Users\$env:USERNAME\.config\starship.toml" `
    -Target "C:\Users\$env:USERNAME\dotfiles\starship.toml"

Write-Host "Done! Restart Windows Terminal." -ForegroundColor Green
Write-Host "Don't forget to install JetBrainsMono Nerd Font from https://www.nerdfonts.com" -ForegroundColor Yellow