#!/usr/bin/env bash

set -euo pipefail

check_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Erreur : '$1' n'est pas installé."
        exit 1
    fi
}

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installation des dotfiles..."
echo

echo "-> Vérification des prérequis..."
check_command git
check_command brew
echo "✓ Prérequis"
echo

echo "-> Installation des logiciels Homebrew..."
brew bundle --file="$DOTFILES_DIR/Brewfile"
echo "✓ Homebrew"
echo

echo "-> Vérification de la commande 'code'..."

if [ -d "/Applications/Visual Studio Code.app" ] && ! command -v code >/dev/null 2>&1; then
    ln -sf "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" \
        /opt/homebrew/bin/code
fi

if command -v code >/dev/null 2>&1; then
    echo "✓ VS Code"
else
    echo "⚠ La commande 'code' n'est pas disponible."
fi
echo

echo "-> Configuration de Zsh..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/zsh/.zsh_aliases" ~/.zsh_aliases
ln -sf "$DOTFILES_DIR/zsh/.zsh_functions" ~/.zsh_functions
ln -sf "$DOTFILES_DIR/zsh/.zsh_plugins" ~/.zsh_plugins
ln -sf "$DOTFILES_DIR/zsh/.p10k.zsh" ~/.p10k.zsh
echo "✓ Zsh"
echo

echo "-> Configuration de Git..."
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig

GIT_CONFIG_NEEDS_EDIT=false

if [ -f "$HOME/.gitconfig.local" ]; then
    echo "✓ ~/.gitconfig.local existe déjà, fichier conservé"
else
    while true; do
        read -rp "Configurer ton identité Git maintenant ? [O/n] " answer

        case "$answer" in
            [OoYy] | "")
                read -rp "Nom Git : " git_name
                read -rp "E-mail Git : " git_email

                git config --file "$HOME/.gitconfig.local" \
                    user.name "$git_name"

                git config --file "$HOME/.gitconfig.local" \
                    user.email "$git_email"

                echo "✓ ~/.gitconfig.local créé"
                break
                ;;

            [Nn])
                cp \
                    "$DOTFILES_DIR/git/.gitconfig.local.example" \
                    "$HOME/.gitconfig.local"

                GIT_CONFIG_NEEDS_EDIT=true

                echo "✓ Modèle ~/.gitconfig.local créé"
                break
                ;;

            *)
                echo "Réponse invalide. Entre O ou N."
                ;;
        esac
    done
fi

echo "✓ Git"
echo

echo "-> Configuration de Lazygit..."
LAZYGIT_CONFIG_DIR="$HOME/Library/Application Support/lazygit"
mkdir -p "$LAZYGIT_CONFIG_DIR"
ln -sf \
    "$DOTFILES_DIR/lazygit/config.yml" \
    "$LAZYGIT_CONFIG_DIR/config.yml"

echo "✓ Lazygit"
echo

echo "-> Configuration de Yazi..."
mkdir -p ~/.config/yazi
ln -sf "$DOTFILES_DIR/yazi/yazi.toml" ~/.config/yazi/yazi.toml
ln -sf "$DOTFILES_DIR/yazi/keymap.toml" ~/.config/yazi/keymap.toml
ln -sf "$DOTFILES_DIR/yazi/theme.toml" ~/.config/yazi/theme.toml
echo "✓ Yazi"
echo

echo "-> Configuration de Neovim..."
mkdir -p ~/.config

if [ -e ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
    echo "Erreur : ~/.config/nvim existe déjà et n'est pas un lien symbolique."
    echo "Déplace ou supprime ce dossier avant de relancer l'installation."
    exit 1
fi

ln -sfn "$DOTFILES_DIR/nvim" ~/.config/nvim

echo "✓ Neovim"
echo

echo "✓ Installation terminée."
echo
echo "Actions restantes :"

if [ "$GIT_CONFIG_NEEDS_EDIT" = true ]; then
    echo "  - Modifier ~/.gitconfig.local avec ton nom et ton e-mail Git."
fi

echo "  - Redémarrer le terminal ou exécuter : source ~/.zshrc"