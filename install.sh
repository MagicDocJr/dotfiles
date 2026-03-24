#!/bin/bash

# ── Detect dotfiles location ──────────────────────────────
if [ -d "/mnt/c/Users/$USER/dotfiles" ]; then
    DOTFILES="/mnt/c/Users/$USER/dotfiles"
else
    DOTFILES="$HOME/dotfiles"
fi

echo "Using dotfiles from: $DOTFILES"

# ── Apt packages ─────────────────────────────────────────
echo "Installing apt packages..."
sudo apt update
sudo apt install -y zsh bat eza ripgrep fzf zoxide btop git-delta

# ── Fastfetch ────────────────────────────────────────────
if ! grep -q "zhangsongcui3371" /etc/apt/sources.list.d/* 2>/dev/null; then
    sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
    sudo apt update
fi
sudo apt install fastfetch -y

# ── Snap packages ────────────────────────────────────────
echo "Installing snap packages..."
snap list helix &>/dev/null || sudo snap install helix --classic
snap list yazi &>/dev/null || sudo snap install yazi --classic
snap list glow &>/dev/null || sudo snap install glow
snap list tldr &>/dev/null || sudo snap install tldr

# ── Oh My Zsh ────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed, skipping."
fi

# ── Oh My Zsh plugins ────────────────────────────────────
echo "Installing zsh plugins..."
clone_if_missing() {
    if [ ! -d "$2" ]; then
        git clone "$1" "$2"
    else
        echo "Skipping $(basename $2) — already exists"
    fi
}

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
clone_if_missing https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/zsh-you-should-use

# ── Starship ─────────────────────────────────────────────
if ! command -v starship &>/dev/null; then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
    echo "Starship already installed, skipping."
fi

# ── NVM ──────────────────────────────────────────────────
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
else
    echo "nvm already installed, skipping."
fi

# ── LSP servers ──────────────────────────────────────────
echo "Installing language servers..."
npm install -g typescript-language-server typescript
npm install -g @angular/language-server
npm install -g bash-language-server
npm install -g vscode-langservers-extracted

# ── Symlinks ─────────────────────────────────────────────
echo "Creating symlinks..."
mkdir -p ~/.config
mkdir -p ~/.config/helix

ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"
[ -f "$DOTFILES/.gitconfig" ] && ln -sf "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
[ -f "$DOTFILES/helix-config.toml" ] && ln -sf "$DOTFILES/helix-config.toml" ~/.config/helix/config.toml
[ -f "$DOTFILES/helix-languages.toml" ] && ln -sf "$DOTFILES/helix-languages.toml" ~/.config/helix/languages.toml

# ── Set zsh as default ───────────────────────────────────
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    chsh -s $(which zsh)
else
    echo "zsh already default shell, skipping."
fi

echo ""
echo "Done! Restart your terminal."
