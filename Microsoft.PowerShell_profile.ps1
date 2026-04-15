# ── Prompt ───────────────────────────────────────────────
Invoke-Expression (&starship init powershell)

# ── Modules ──────────────────────────────────────────────
Import-Module -Name Terminal-Icons   # icons in file listings
Import-Module -Name ZLocation        # jump to recent dirs with z

# ── Autocomplete ─────────────────────────────────────────
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# ── Aliases ──────────────────────────────────────────────
function cat  { bat $args }
function ls   { eza --icons $args }
function ll   { eza -la --icons $args }
function grep { rg $args }
function .. { cd .. }
function ... { cd ../.. }
function profile { code $PROFILE }
function starshiprc { code $env:USERPROFILE\.config\starship.toml }
Import-Module "C:\Users\aleks\src\NorskRikstoto\beta.rikstoto.no\src\Web\.powershell\migrate-control-flow.psm1"

Import-Module "C:\Users\aleks\src\NorskRikstoto\beta.rikstoto.no\src\Web\.powershell\migrate-signal-inputs.psm1"
