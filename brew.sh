#!/usr/bin/env bash

set -euo pipefail

echo "→ Vérification de Homebrew..."

if ! command -v brew >/dev/null 2>&1; then
    echo "Erreur : Homebrew n'est pas installé."
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo
echo "→ Génération du Brewfile..."

brew bundle dump \
    --file="$DOTFILES_DIR/Brewfile" \
    --force

echo
echo "✓ Brewfile mis à jour."