# macOS Dotfiles

[Languages / Langues](README.md) · [Français](README.fr.md) · English

Development configuration for Apple Silicon Macs. The repository includes
configuration files and an installer that checks for conflicts before creating
symlinks.

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

## Dependencies

The [Brewfile](Brewfile) installs the following tools as part of the standard
setup. Install Git, Homebrew, Oh My Zsh, and VS Code first.

- Terminal and navigation · Powerlevel10k, Zsh Autocomplete,
  Zsh Autosuggestions, Zsh Syntax Highlighting, FZF, Zoxide, Bat, and Eza.
- Editing and search · Neovim, Lazygit, Yazi, fd, ripgrep, jq, and the Rosé Pine
  extension for VS Code.
- Runtimes and previews · Node.js, Python 3.11, FFmpeg, ImageMagick, Poppler,
  and 7-Zip.

### Optional tools

- iTerm2 lets you use the included color preset.
- NVM manages multiple Node.js versions. Zsh loads it from Homebrew or
  `NVM_DIR` (default: `~/.nvm`) when present.
- Zsh uses OpenJDK 25 when installed through Homebrew. The `rars` alias needs
  a `java` command and a separate `~/rars-1.7.jar` file.
- OPAM loads only if its initialization script exists.

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

## Customization and uninstall

Edit the configuration files in the repository to update the linked files.
Keep your Git identity in `~/.gitconfig.local`. Git ignores the local software
inventory in `Brewfile.local`.

To uninstall, use `ls -l` to inspect the symlinks. Remove only links to this
repository and restore your backups. The links are the five Zsh files from
the repository in your home directory, `~/.gitconfig`, `~/.config/nvim`,
the three TOML files in `~/.config/yazi`, and `config.yml` in
`~/Library/Application Support/lazygit`. Keep `~/.gitconfig.local` if you plan
to reuse your Git identity. Manage Homebrew packages separately. If the script
created the Homebrew symlink for `code`, you can remove it after checking its
target.

## Automated checks

[GitHub Actions](.github/workflows/shell-checks.yml) runs ShellCheck and
`bash -n` on the Bash scripts and `zsh -n` on the five Zsh files on every push
and pull request. These checks run on Ubuntu and do not run the macOS
installer.

## Repository structure

```text
dotfiles/
├── .github/workflows/shell-checks.yml
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
├── README.fr.md
└── README.md
```
