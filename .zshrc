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
alias rld='source ~/.zshrc'

alias y='yazi'
alias zshrc='nano ~/.zshrc'
alias starshiprc='nano ~/.config/starship.toml'

# ── Editor ───────────────────────────────────────────────
export EDITOR='helix'

# ── History ──────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt share_history
setopt hist_ignore_dups

# ── Tools ────────────────────────────────────────────────
eval "$(zoxide init zsh)"
export PATH=$PATH:/snap/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
