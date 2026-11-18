# Mes Dotfiles

Bienvenue dans mon environnement de développement.

Ce dépôt contient toute la configuration que j'utilise quotidiennement sur macOS
pour développer.

L'objectif n'est pas seulement d'avoir un joli terminal, mais surtout un
environnement :

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

## Installation

### Prérequis

La configuration actuelle cible les Mac Apple Silicon avec Homebrew installé
dans `/opt/homebrew`.

- Installez Git et Homebrew, puis vérifiez que les commandes `git` et `brew`
  sont disponibles dans votre terminal.
- Installez Oh My Zsh dans `~/.oh-my-zsh`, où le fichier `.zshrc` le charge.
- Installez Visual Studio Code dans `/Applications` et rendez la commande `code`
  disponible avant de lancer le script. Le `Brewfile` contient l’extension Rosé
  Pine. Si `code` est introuvable, ouvrez la palette de commandes de VS Code et
  exécutez **Shell Command: Install 'code' command in PATH**, puis ouvrez un
  nouveau terminal.

### Installer les dotfiles

Clonez le dépôt dans `~/dotfiles`. Les alias Zsh `dotfiles`, `dot` et
`brewfile` utilisent ce chemin. Si vous choisissez un autre emplacement, adaptez
les chemins dans [`zsh/.zsh_aliases`](zsh/.zsh_aliases).

```bash
git clone https://github.com/pjchariol/macos-dotfiles-public.git ~/dotfiles
cd ~/dotfiles
```

Rendre le script exécutable puis lancer l'installation :

```bash
chmod +x install.sh
./install.sh
```

Le script installe les dépendances déclarées dans le `Brewfile` et crée les
liens symboliques nécessaires pour Git, Zsh, Yazi, Lazygit et Neovim.

Si le script détecte des configurations existantes en conflit, il affiche les
chemins concernés et s’arrête avant l’installation. Déplacez ces fichiers vers
un dossier de sauvegarde, puis relancez le script.

Après l’installation, ouvrez un nouveau terminal ou exécutez `source ~/.zshrc`.

### Configuration de Git

Les informations personnelles Git ne sont pas incluses dans ce dépôt.

Si `~/.gitconfig.local` n'existe pas, le script d'installation propose de
configurer automatiquement votre identité Git.

Si vous choisissez de ne pas le faire immédiatement, un fichier
`~/.gitconfig.local` est créé à partir du modèle fourni. Il suffit alors de
renseigner vos informations :

```ini
[user]
    name = Votre Nom
    email = votre@email.com
```

> Le fichier `~/.gitconfig.local` est volontairement exclu du dépôt afin de ne
> jamais versionner d'informations personnelles.

---

## Outils utilisés

### Homebrew

Le `Brewfile` versionné liste les dépendances de la configuration publique. Pour
exporter l’inventaire des logiciels de votre Mac, lancez `bash ./brew.sh` depuis
le dépôt. Le script écrit dans `Brewfile.local`, ignoré par Git.

---

### Git

Configuration Git personnalisée avec :

- aliases utiles
- rebase par défaut
- `rerere`
- `zdiff3`
- configuration reproductible

---

### Zsh

Configuration entièrement documentée et séparée en plusieurs fichiers :

- `.zsh_aliases`
- `.zsh_functions`
- `.zsh_plugins`
- `.zshrc`

---

### Powerlevel10k

Thème du terminal affichant notamment :

- la branche Git
- le dossier courant
- l'état du dépôt
- la durée des commandes
- les indicateurs utiles

---

### iTerm2

Terminal principal utilisant le thème **Rosé Pine Moon**.

Installez iTerm2 séparément. Dans les réglages d’iTerm2, ouvrez
**Profiles → Colors → Color Presets**, choisissez **Import**, puis
sélectionnez
[iterm2/rose-pine-moon.itermcolors](iterm2/rose-pine-moon.itermcolors).
Sélectionnez ensuite **Rosé Pine Moon** dans les préréglages du profil.

---

### Zoxide

Navigation intelligente entre les dossiers.

Après avoir visité un dossier, par exemple `~/Projets/exemple`, vous pouvez y
revenir en tapant une partie de son nom.

```bash
z exemple
```

---

### FZF

Recherche interactive dans le terminal.

Principales fonctionnalités :

- historique (`Ctrl + R`)
- recherche de fichiers (`Ctrl + T`)
- recherche de dossiers (`Option + C`)

---

### Yazi

Gestionnaire de fichiers moderne dans le terminal.

Permet notamment :

- naviguer rapidement
- ouvrir VS Code
- prévisualiser des fichiers
- éviter Finder

Personnalisé avec le thème **Rosé Pine**.

---

### Lazygit

Interface Git dans le terminal.

Permet de gérer Git efficacement sans mémoriser toutes les commandes.

Personnalisé avec le thème **Rosé Pine**.

---

### VS Code

Éditeur principal.

Le `Brewfile` installe l’extension Rosé Pine. Pour activer **Rosé Pine Moon**,
sélectionnez-le dans la commande **Preferences: Color Theme** de VS Code.

---

### Neovim

Éditeur de texte moderne utilisé pour les modifications rapides et le
développement directement dans le terminal.

Configuration basée sur **LazyVim**, avec notamment :

- gestionnaire de plugins `lazy.nvim`
- thème **Rosé Pine Moon**
- Treesitter
- LSP
- autocomplétion
- formatage automatique

---

### Bat

Remplacement moderne de `cat`.

Ajoute :

- coloration syntaxique
- numéros de ligne
- meilleur affichage

---

### Eza

Remplacement moderne de `ls`.

Utilisé pour l'affichage des fichiers et de l'arborescence.

---

## Structure du dépôt

```text
dotfiles/
├── .gitignore
├── git/
├── iterm2/
├── lazygit/
├── nvim/
├── yazi/
├── zsh/
├── Brewfile
├── brew.sh
├── install.sh
└── README.md
```

---
