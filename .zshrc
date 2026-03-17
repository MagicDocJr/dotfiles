autoload -Uz compinit && compinit -ieval "$(starship init zsh)"
zstyle ":completion:*:*:docker:*" option-stacking yes
# ── Aliases ──────────────────────────────────────────────
alias ls='eza --icons'
alias ll='eza -la --icons'
alias cat='bat'
alias grep='rg'

# ── Autocomplete ─────────────────────────────────────────
autoload -Uz compinit && compinit -i

# ── History ──────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt share_history
setopt hist_ignore_dups
