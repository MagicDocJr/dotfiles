# ── Oh My Zsh ────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-you-should-use
  fzf
)

source $ZSH/oh-my-zsh.sh

# ── Prompt ───────────────────────────────────────────────
eval "$(starship init zsh)"

# ── Aliases ──────────────────────────────────────────────
alias ls='eza --icons'
alias ll='eza -la --icons'
alias cat='batcat'
alias grep='rg'
alias ..='cd ..'
alias ...='cd ../..'
alias zshrc='code ~/.zshrc'
alias starshiprc='code ~/.config/starship.toml'
# ── History ──────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt share_history
setopt hist_ignore_dups
eval "$(zoxide init zsh)"
