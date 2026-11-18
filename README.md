# Mes Dotfiles

Bienvenue dans mon environnement de développement.

Ce dépôt contient toute la configuration que j'utilise quotidiennement sur macOS pour développer.

L'objectif n'est pas seulement d'avoir un joli terminal, mais surtout un environnement :

- rapide
- cohérent
- documenté
- reproductible
- agréable à utiliser

---

## Aperçu

- Homebrew
- Zsh + Oh My Zsh
- Powerlevel10k
- iTerm2
- Neovim (LazyVim)
- Yazi
- Lazygit
- FZF
- Zoxide
- Bat
- Eza
- VS Code

---

# Installation

Cloner le dépôt dans le dossier personnel :

```bash
git clone https://github.com/pjchariol/macos-dotfiles-public.git ~/dotfiles
cd ~/dotfiles
```

Rendre le script exécutable puis lancer l'installation :

```bash
chmod +x install.sh
./install.sh
```

Le script installe les dépendances déclarées dans le `Brewfile` et crée les liens symboliques nécessaires pour Git, Zsh, Yazi, Lazygit et Neovim.

## Configuration de Git

Les informations personnelles Git ne sont pas incluses dans ce dépôt.

Si `~/.gitconfig.local` n'existe pas, le script d'installation propose de configurer automatiquement votre identité Git.

Si vous choisissez de ne pas le faire immédiatement, un fichier `~/.gitconfig.local` est créé à partir du modèle fourni. Il suffit alors de renseigner vos informations :

```ini
[user]
    name = Votre Nom
    email = votre@email.com
```

> Le fichier `~/.gitconfig.local` est volontairement exclu du dépôt afin de ne jamais versionner d'informations personnelles.

---
# Outils utilisés

## Homebrew

Gestionnaire de paquets utilisé pour installer et maintenir tous les outils de développement.

---

## Git

Configuration Git personnalisée avec :

- aliases utiles
- rebase par défaut
- `rerere`
- `zdiff3`
- configuration reproductible

---

## Zsh

Configuration entièrement documentée et séparée en plusieurs fichiers :

- `.zsh_aliases`
- `.zsh_functions`
- `.zsh_plugins`
- `.zshrc`

---

## Powerlevel10k

Thème du terminal affichant notamment :

- la branche Git
- le dossier courant
- l'état du dépôt
- la durée des commandes
- les indicateurs utiles

---

## iTerm2

Terminal principal utilisant le thème **Rosé Pine Moon**.

---

## Zoxide

Navigation intelligente entre les dossiers.

Au lieu de :

```bash
cd Documents/Cours/Session\ 6/TP
```

je peux simplement écrire :

```bash
z tp
```

---

## FZF

Recherche interactive dans le terminal.

Principales fonctionnalités :

- historique (`Ctrl + R`)
- recherche de fichiers (`Ctrl + T`)
- recherche de dossiers (`Option + C`)

---

## Yazi

Gestionnaire de fichiers moderne dans le terminal.

Permet notamment :

- naviguer rapidement
- ouvrir VS Code
- prévisualiser des fichiers
- éviter Finder

Personnalisé avec le thème **Rosé Pine**.

---

## Lazygit

Interface Git dans le terminal.

Permet de gérer Git efficacement sans mémoriser toutes les commandes.

Personnalisé avec le thème **Rosé Pine**.

---

## VS Code

Éditeur principal.

Utilise le thème **Rosé Pine Moon** pour rester cohérent avec le reste de l'environnement.

---

## Neovim

Éditeur de texte moderne utilisé pour les modifications rapides et le développement directement dans le terminal.

Configuration basée sur **LazyVim**, avec notamment :

- gestionnaire de plugins `lazy.nvim`
- thème **Rosé Pine Moon**
- Treesitter
- LSP
- autocomplétion
- formatage automatique

---

## Bat

Remplacement moderne de `cat`.

Ajoute :

- coloration syntaxique
- numéros de ligne
- meilleur affichage

---

## Eza

Remplacement moderne de `ls`.

Utilisé pour l'affichage des fichiers et de l'arborescence.

---

# Structure du dépôt

```
dotfiles/
├── docs/
├── git/
├── iterm2/
├── lazygit/
├── nvim/
├── screenshots/
├── yazi/
├── zsh/
├── Brewfile
├── brew.sh
├── install.sh
└── README.md
```

---
