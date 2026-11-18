#!/usr/bin/env bash

set -euo pipefail

echo "→ Vérification de Homebrew..."

if ! command -v brew >/dev/null 2>&1; then
    echo "Erreur : Homebrew n'est pas installé."
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo
LOCAL_BREWFILE="$DOTFILES_DIR/Brewfile.local"
if [[ -L "$LOCAL_BREWFILE" || ( -e "$LOCAL_BREWFILE" && ! -f "$LOCAL_BREWFILE" ) ]]; then
    printf 'Impossible de remplacer ce chemin : %s\n' "$LOCAL_BREWFILE" >&2
    exit 1
fi
echo "→ Génération de l’inventaire Homebrew local..."

brew bundle dump \
    --file="$LOCAL_BREWFILE" \
    --force

echo
echo "✓ Inventaire mis à jour : $LOCAL_BREWFILE"
