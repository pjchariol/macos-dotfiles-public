# ============================================================
# CONFIGURATION PRINCIPALE ZSH
# ============================================================
#
# Ce fichier sert de point d'entrée à toute la configuration
# du terminal.
#
# Les différentes responsabilités sont séparées dans :
#
#   ~/.zsh_aliases
#       raccourcis de commandes
#
#   ~/.zsh_functions
#       fonctions personnelles
#
#   ~/.zsh_plugins
#       outils et plugins Zsh
#
#   ~/.p10k.zsh
#       apparence de Powerlevel10k
#
# ============================================================


# ------------------------------------------------------------
# POWERLEVEL10K — INSTANT PROMPT
# ------------------------------------------------------------
# Affiche le prompt immédiatement pendant que le reste de la
# configuration Zsh se charge en arrière-plan.
#
# Ce bloc doit rester près du début du fichier.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ------------------------------------------------------------
# OH MY ZSH
# ------------------------------------------------------------
# Indique le dossier dans lequel Oh My Zsh est installé.
export ZSH="$HOME/.oh-my-zsh"

# Powerlevel10k est chargé séparément plus bas.
# On désactive donc le thème par défaut de Oh My Zsh pour éviter
# de charger inutilement deux thèmes.
ZSH_THEME=""

# Active les plugins fournis par Oh My Zsh.
#
# git
#   Ajoute plusieurs alias Git, dont :
#
#     gst    -> git status
#     gaa    -> git add --all
#     gl     -> git pull
#     gp     -> git push
#
#   Ton alias "gitadog" dépend aussi de l'alias "adog" fourni
#   par ce plugin.
#
# web-search
#   Permet de lancer des recherches Web directement depuis
#   le terminal.
#
#   Exemples :
#
#     google zsh
#     github lazygit
#     youtube rose pine
#     stackoverflow zsh alias
#     wiki macOS
#
#   Documentation :
#     https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search
plugins=(
  git
  web-search
)

# Charge Oh My Zsh avec la configuration définie ci-dessus.
if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi


# ------------------------------------------------------------
# OPAM / OCAML
# ------------------------------------------------------------
# Charge l'environnement OPAM s'il est installé.
#
# Cela configure notamment :
#
#   - le PATH des outils OCaml
#   - la version active du compilateur OCaml
#   - l'autocomplétion de la commande opam
#
# Les redirections vers /dev/null empêchent l'affichage de
# messages inutiles au démarrage du terminal.
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] ||
  source "$HOME/.opam/opam-init/init.zsh" >/dev/null 2>&1


# ------------------------------------------------------------
# CONFIGURATION PERSONNELLE
# ------------------------------------------------------------
# Charge les alias personnels, s'ils existent.
[[ -r "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"

# Charge les fonctions personnelles, si elles existent.
[[ -r "$HOME/.zsh_functions" ]] && source "$HOME/.zsh_functions"

typeset _dotfiles_brew_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}"

# Charge fzf, zoxide et les autres plugins installés.
[[ -r "$HOME/.zsh_plugins" ]] && source "$HOME/.zsh_plugins"


# ------------------------------------------------------------
# POWERLEVEL10K
# ------------------------------------------------------------
# Charge le thème Powerlevel10k.
typeset _dotfiles_p10k="$_dotfiles_brew_prefix/share/powerlevel10k/powerlevel10k.zsh-theme"
if [[ -r "$_dotfiles_p10k" ]]; then
  source "$_dotfiles_p10k"
  [[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
fi
unset _dotfiles_p10k

# ------------------------------------------------------------
# OUTILS FACULTATIFS
# ------------------------------------------------------------
typeset _dotfiles_nvm="$_dotfiles_brew_prefix/opt/nvm"
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [[ -s "$_dotfiles_nvm/nvm.sh" ]]; then
  source "$_dotfiles_nvm/nvm.sh"
elif [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
fi
if (( $+functions[complete] )) && [[ -s "$_dotfiles_nvm/etc/bash_completion.d/nvm" ]]; then
  source "$_dotfiles_nvm/etc/bash_completion.d/nvm"
fi

typeset _dotfiles_jdk="$_dotfiles_brew_prefix/opt/openjdk@25/libexec/openjdk.jdk/Contents/Home"
if [[ -x "$_dotfiles_jdk/bin/java" ]]; then
  export JAVA_HOME="$_dotfiles_jdk"
  path=("$JAVA_HOME/bin" "${(@)path:#$JAVA_HOME/bin}")
fi
unset _dotfiles_nvm _dotfiles_jdk

# ------------------------------------------------------------
# ZSH SYNTAX HIGHLIGHTING
# ------------------------------------------------------------
# Colore les commandes valides et invalides pendant la saisie.
#
# Ce plugin doit rester à la toute fin du fichier, après tous
# les autres plugins et toute la configuration Zsh.
typeset _dotfiles_highlight="$_dotfiles_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -r "$_dotfiles_highlight" ]]; then
  source "$_dotfiles_highlight"
fi
unset _dotfiles_highlight _dotfiles_brew_prefix
