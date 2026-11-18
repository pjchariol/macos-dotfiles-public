#!/usr/bin/env bash

set -euo pipefail

check_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        printf "Erreur : '%s' n'est pas disponible dans le PATH.\n" "$1" >&2
        exit 1
    fi
}

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

echo "Installation des dotfiles..."
echo

echo "-> Vérification des prérequis..."
check_command git
check_command brew
echo "✓ Prérequis"
echo

echo "-> Vérification des chemins de configuration..."

LAZYGIT_CONFIG_DIR="$HOME/Library/Application Support/lazygit"
sources=(
    zsh/{.zshrc,.zsh_aliases,.zsh_functions,.zsh_plugins,.p10k.zsh}
    git/.gitconfig
    lazygit/config.yml
    yazi/{yazi.toml,keymap.toml,theme.toml}
    nvim
)
destinations=(
    "$HOME"/{.zshrc,.zsh_aliases,.zsh_functions,.zsh_plugins,.p10k.zsh}
    "$HOME/.gitconfig"
    "$LAZYGIT_CONFIG_DIR/config.yml"
    "$HOME/.config/yazi"/{yazi.toml,keymap.toml,theme.toml}
    "$HOME/.config/nvim"
)

conflicts=()
for directory in "$HOME/.config" "$HOME/.config/yazi" \
    "$HOME/Library" "$HOME/Library/Application Support" "$LAZYGIT_CONFIG_DIR"; do
    if [[ ( -e "$directory" || -L "$directory" ) && ! -d "$directory" ]]; then
        conflicts+=("$directory")
    fi
done

for index in "${!destinations[@]}"; do
    destination="${destinations[index]}"
    if [[ -L "$destination" && "$(readlink "$destination")" == "$DOTFILES_DIR/${sources[index]}" ]]; then
        continue
    fi
    if [[ -e "$destination" || -L "$destination" ]]; then
        conflicts+=("$destination")
    fi
done

local_git_config="$HOME/.gitconfig.local"
if [[ ( -e "$local_git_config" || -L "$local_git_config" ) && ! -f "$local_git_config" ]]; then
    conflicts+=("$local_git_config")
fi

if (( ${#conflicts[@]} > 0 )); then
    printf 'Installation arrêtée. Déplace les chemins suivants avant de relancer :\n' >&2
    printf '  - %s\n' "${conflicts[@]}" >&2
    exit 1
fi

if [[ ! -r "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]]; then
    printf 'Installe Oh My Zsh dans ~/.oh-my-zsh avant de relancer.\n' >&2
    exit 1
fi

echo "-> Vérification de la commande 'code'..."
if ! command -v code >/dev/null 2>&1; then
    code_source="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
    code_destination="$(brew --prefix)/bin/code"
    if [[ -x "$code_source" && ! -e "$code_destination" && ! -L "$code_destination" ]]; then
        ln -s "$code_source" "$code_destination"
    fi
fi
check_command code

echo "-> Installation des logiciels Homebrew..."
brew bundle --file="$DOTFILES_DIR/Brewfile"
echo "✓ Homebrew"
echo

echo "-> Création des liens de configuration..."
mkdir -p "$LAZYGIT_CONFIG_DIR" "$HOME/.config/yazi"

for index in "${!destinations[@]}"; do
    destination="${destinations[index]}"
    source="$DOTFILES_DIR/${sources[index]}"
    if [[ -L "$destination" && "$(readlink "$destination")" == "$source" ]]; then
        continue
    fi
    ln -s "$source" "$destination"
done
echo "✓ Liens de configuration"
echo

echo "-> Configuration de Git..."
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

echo "✓ Installation terminée."
echo
echo "Actions restantes :"

if [ "$GIT_CONFIG_NEEDS_EDIT" = true ]; then
    echo "  - Modifier ~/.gitconfig.local avec ton nom et ton e-mail Git."
fi

echo "  - Redémarrer le terminal ou exécuter : source ~/.zshrc"
