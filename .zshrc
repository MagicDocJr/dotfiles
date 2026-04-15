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

# ── Yazi ────────────────────────────────────────────────
function yazi_jump() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd=$(cat "$tmp"); then
        [ -d "$cwd" ] && cd "$cwd"
    fi
    rm -f "$tmp"
}
bindkey -s '^Y' 'yazi_jump\n'

# ── Aliases ──────────────────────────────────────────────
alias ls='eza --icons'
alias ll='eza -la --icons'
alias cat='batcat'
alias grep='rg'
alias rld='source ~/.zshrc'
alias hx='helix'
alias y='yazi'
alias zshrc='helix ~/.zshrc'
alias starshiprc='helix ~/.config/starship.toml'
alias zj='zellij'

# ── Editor ───────────────────────────────────────────────
export EDITOR='helix'

# ── History ──────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt share_history
setopt hist_ignore_dups
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
# ── Android SDK ──────────────────────────────────────────
export ANDROID_HOME=/mnt/c/Users/aleks/AppData/Local/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# ── Tools ────────────────────────────────────────────────
eval "$(zoxide init zsh)"
export PATH=$PATH:/snap/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export PATH="$HOME/.local/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"

