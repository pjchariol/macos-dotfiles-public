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
echo "→ Génération de l’inventaire Homebrew local..."

brew bundle dump \
    --file="$LOCAL_BREWFILE" \
    --force

echo
echo "✓ Inventaire mis à jour : $LOCAL_BREWFILE"
