# ── PowerShell 7 ──────────────────────────────────────────
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "Installing PowerShell 7..." -ForegroundColor Cyan
    winget install Microsoft.PowerShell
    Write-Host "Restart terminal as PowerShell 7 and re-run this script." -ForegroundColor Yellow
    exit
} else {
    Write-Host "PowerShell 7 already installed, skipping." -ForegroundColor Green
}

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
$tools = @("starship", "bat", "eza", "ripgrep", "tldr", "yazi", "fastfetch", "glow")
foreach ($tool in $tools) {
    if (!(scoop list $tool 2>$null | Select-String $tool)) {
        scoop install $tool
    } else {
        Write-Host "$tool already installed, skipping." -ForegroundColor Green
    }
}

# ── PowerShell modules ────────────────────────────────────
Write-Host "Installing PowerShell modules..." -ForegroundColor Cyan
if (!(Get-Module -ListAvailable -Name Terminal-Icons)) {
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force -Scope CurrentUser
} else {
    Write-Host "Terminal-Icons already installed, skipping." -ForegroundColor Green
}
if (!(Get-Module -ListAvailable -Name ZLocation)) {
    Install-Module -Name ZLocation -Repository PSGallery -Force -Scope CurrentUser
} else {
    Write-Host "ZLocation already installed, skipping." -ForegroundColor Green
}

# ── PowerToys ─────────────────────────────────────────────
if (!(Get-Command powertoys -ErrorAction SilentlyContinue)) {
    Write-Host "Installing PowerToys..." -ForegroundColor Cyan
    winget install Microsoft.PowerToys
} else {
    Write-Host "PowerToys already installed, skipping." -ForegroundColor Green
}

# ── Symlinks ──────────────────────────────────────────────
Write-Host "Creating symlinks..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path "$HOME\Documents\PowerShell" -Force | Out-Null
New-Item -ItemType Directory -Path "$HOME\.config" -Force | Out-Null

New-Item -ItemType SymbolicLink -Force `
    -Path "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" `
    -Target "$HOME\dotfiles\Microsoft.PowerShell_profile.ps1"
New-Item -ItemType SymbolicLink -Force `
    -Path "$HOME\.config\starship.toml" `
    -Target "$HOME\dotfiles\starship.toml"

Write-Host "Done! Restart Windows Terminal." -ForegroundColor Green
Write-Host ""
Write-Host "Manual steps required:" -ForegroundColor Yellow
Write-Host "  1. Install JetBrainsMono Nerd Font: https://www.nerdfonts.com/font-downloads" -ForegroundColor Yellow
Write-Host "  2. Set font in Windows Terminal -> each profile -> Appearance" -ForegroundColor Yellow
Write-Host "  3. Add Tokyo Night theme from https://windowsterminalthemes.dev" -ForegroundColor Yellow
Write-Host "  4. Set default profile to PowerShell in Windows Terminal settings" -ForegroundColor Yellow
Write-Host "  5. Set Ubuntu starting directory to /mnt/c/Users/$env:USERNAME" -ForegroundColor Yellow
