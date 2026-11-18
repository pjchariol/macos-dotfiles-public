# macOS Dotfiles

[Français](README.md) · English

This repository contains my everyday macOS development configuration. It
includes Homebrew, Zsh with Oh My Zsh and Powerlevel10k, iTerm2, Neovim with
LazyVim, Yazi, Lazygit, FZF, Zoxide, Bat, Eza, and Visual Studio Code.

## Installation

### Prerequisites

This configuration targets Apple Silicon Macs with Homebrew in `/opt/homebrew`.

- Install Git and Homebrew. Check that `git` and `brew` are available in your
  terminal.
- Install Oh My Zsh in `~/.oh-my-zsh` so `.zshrc` can load it.
- Install Visual Studio Code in `/Applications` and make sure `code` is
  available before running the installer. To add it to your PATH, run
  **Shell Command: Install 'code' command in PATH** from the VS Code Command
  Palette and open a new terminal.

### Install the dotfiles

Clone the repository into `~/dotfiles`. Zsh aliases such as `dotfiles`, `dot`,
and `brewfile` use this path. If you choose another location, update the paths
in [`zsh/.zsh_aliases`](zsh/.zsh_aliases).

```bash
git clone https://github.com/pjchariol/macos-dotfiles-public.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The installer installs the packages and VS Code extension listed in
`Brewfile` and creates symlinks for Git, Zsh, Yazi, Lazygit, and Neovim.

If the installer finds conflicting configuration files, it lists their paths
and stops before installing anything. Move those files to a backup directory
and run the installer again.

Open a new terminal or run `source ~/.zshrc` after installation.

### Git identity

The installer keeps an existing `~/.gitconfig.local`. If the file is missing,
it offers to create it with your Git name and email. If you decline, it copies
the example file so you can fill it in later.

```ini
[user]
    name = Your Name
    email = your.email@example.com
```

The file lives in your home directory, outside the repository.

## Tools and configuration

### Homebrew

The tracked `Brewfile` lists the dependencies for this setup. To export your
Mac's software inventory, run `bash ./brew.sh` from the repository. It writes
to `Brewfile.local`, which Git ignores.

### Git

The Git configuration includes aliases, rebase by default when pulling,
`rerere` to reuse recorded conflict resolutions, and `zdiff3` conflict markers.

### Zsh and Powerlevel10k

Zsh configuration is split across `.zshrc`, `.zsh_aliases`, `.zsh_functions`,
and `.zsh_plugins`. The prompt shows information such as the current directory,
Git branch and status, and command duration.

### iTerm2

Install iTerm2 separately. In its settings, go to **Profiles → Colors →
Color Presets**, choose **Import**, and select
[`rose-pine-moon.itermcolors`](iterm2/rose-pine-moon.itermcolors). Then choose
**Rosé Pine Moon** for your profile.

### Zoxide

After visiting a directory such as `~/Projects/example`, you can jump back
to it using part of its name.

```bash
z example
```

### FZF

Use `Ctrl + R` to search command history, `Ctrl + T` to search files, and
`Option + C` to jump to a directory.

### Yazi and Lazygit

Yazi provides file previews and opens selected files in VS Code. Lazygit
provides a terminal interface for Git. Both are styled with **Rosé Pine**.

### Visual Studio Code

The `Brewfile` installs the Rosé Pine extension. Select **Rosé Pine Moon** using
**Preferences: Color Theme** in the Command Palette.

### Neovim

The Neovim setup uses **LazyVim** and `lazy.nvim`, with the **Rosé Pine Moon**
theme, Treesitter, LSP, autocompletion, and automatic formatting.

### Bat and Eza

Bat adds syntax highlighting and line numbers when viewing files. Eza lists
files and displays directory trees.

## Repository structure

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
├── README.en.md
└── README.md
```
