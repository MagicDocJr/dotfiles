# Dotfiles

Personal terminal and shell configuration for Windows 11 and WSL2.

## Setup

### Windows (PowerShell 7)
```powershell
git clone https://github.com/MagicDocJr/dotfiles.git ~/dotfiles
~/dotfiles/install.ps1
```

### WSL2 (Ubuntu + zsh)
```bash
git clone https://github.com/MagicDocJr/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

## Manual steps after install

- Install JetBrainsMono Nerd Font from https://www.nerdfonts.com
- Set font in Windows Terminal → each profile → Appearance
- Set Tokyo Night color scheme from https://windowsterminalthemes.dev

## What's installed

### Windows
| Tool | Description |
|---|---|
| Starship | Prompt |
| bat | Better cat |
| eza | Better ls |
| ripgrep | Better grep |
| yazi | Terminal file explorer |
| fastfetch | System info |
| glow | Markdown renderer |
| tldr | Quick command examples |
| Terminal-Icons | File icons in PowerShell |
| ZLocation | Jump to recent directories with z |

### WSL2
| Tool | Description |
|---|---|
| zsh | Shell |
| Oh My Zsh | zsh framework |
| Starship | Prompt (shared config) |
| bat | Better cat |
| eza | Better ls |
| ripgrep | Better grep |
| yazi | Terminal file explorer |
| helix | Terminal text editor |
| btop | Activity monitor |
| fzf | Fuzzy finder (Ctrl+R for history) |
| zoxide | Smarter cd with z |
| glow | Markdown renderer |
| tldr | Quick command examples |

### Oh My Zsh plugins
| Plugin | Description |
|---|---|
| git | Hundreds of git aliases |
| zsh-autosuggestions | Ghost text suggestions from history |
| zsh-syntax-highlighting | Green valid, red invalid commands |
| zsh-you-should-use | Reminds you to use your aliases |
| fzf | Fuzzy search integration |
| zsh-abbr | Expanding abbreviations |

## Files
| File | Description |
|---|---|
| `install.ps1` | Windows install script |
| `install.sh` | WSL install script |
| `Microsoft.PowerShell_profile.ps1` | PowerShell config |
| `.zshrc` | zsh config |
| `starship.toml` | Shared prompt config |
