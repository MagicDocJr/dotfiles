#!/bin/bash

# ── Apt packages ─────────────────────────────────────────
echo "Installing apt packages..."
sudo apt update
sudo apt install -y zsh bat eza ripgrep fzf zoxide btop

sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
sudo apt update
sudo apt install fastfetch -y.

# ── Snap packages ────────────────────────────────────────
echo "Installing snap packages..."
sudo snap install helix --classic
sudo snap install yazi --classic
sudo snap install glow
sudo snap install tldr

# ── Oh My Zsh ────────────────────────────────────────────
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# ── Oh My Zsh plugins ────────────────────────────────────
echo "Installing zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-you-should-use
git clone https://github.com/romkatv/zsh-defer ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-defer
git clone https://github.com/olets/zsh-abbr ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-abbr

# ── Starship ─────────────────────────────────────────────
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# ── NVM ──────────────────────────────────────────────────
echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

sudo apt install git-delta -y
# ── LSP servers ──────────────────────────────────────────
echo "Installing language servers..."
npm install -g typescript-language-server typescript
npm install -g svelte-language-server
npm install -g vscode-langservers-extracted
npm install -g @angular/language-server
npm install -g bash-language-server
npm install -g sql-language-server

# ── Helix config ─────────────────────────────────────────
echo "Setting up Helix config..."
mkdir -p ~/.config/helix
ln -sf ~/dotfiles/helix-config.toml ~/.config/helix/config.toml
ln -sf ~/dotfiles/helix-languages.toml ~/.config/helix/languages.toml

# ── Symlinks ─────────────────────────────────────────────
echo "Creating symlinks..."
mkdir -p ~/.config
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml


# ── Set zsh as default ───────────────────────────────────
echo "Setting zsh as default shell..."
chsh -s $(which zsh)

echo ""
echo "Done! Restart your terminal."
echo "Note: zsh-abbr may show a dependency warning on first launch — this resolves itself after a reload."
