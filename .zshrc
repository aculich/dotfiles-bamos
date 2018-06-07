# ~/.zshrc
#
# Brandon Amos
# http://bamos.github.io

# Add additional directories to the path.
pathadd() {
  [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]] && PATH="${PATH:+"$PATH:"}$1"
}

PATH=/usr/local/bin":$PATH" # Prefer brew packages.
pathadd /opt/local/bin
pathadd $HOME/bin
pathadd $HOME/.local/bin
pathadd $HOME/.cabal/bin
REPOS=$HOME/repos
pathadd $REPOS/shell-scripts
pathadd $REPOS/python-scripts/python2.7
pathadd $REPOS/python-scripts/python3
# command -v ruby >/dev/null 2>&1 && \
#   pathadd $(ruby -rubygems -e "puts Gem.user_dir")/bin
unset REPOS

autoload -U zmv

fpath=(/usr/local/share/zsh-completions $fpath)

# Initialize oh-my-zsh.
DISABLE_AUTO_UPDATE='true';
ZSH_THEME=sammy; ZSH=~/.oh-my-zsh; ZSH_CUSTOM=~/.zsh-custom
# zsh options: http://www.cs.elte.hu/zsh-manual/zsh_16.html
plugins=(vi-mode git history-substring-search fabric z)
source $ZSH/oh-my-zsh.sh

# Source external files.
# After oh-my-zsh initialization to override defaults.
[[ -a ~/.funcs/env.sh ]] && source ~/.funcs/env.sh
[[ -a ~/.private ]] && source ~/.private
[[ -a ~/.mpv/shellrc.sh ]] && source ~/.mpv/shellrc.sh

export LS_COLORS='di=38;5;108:fi=00:ln=38;5;116:ex=38;5;186'
export LSCOLORS='ExGxFxdxCxEgEdHbagacad'
export MAILDIR=$HOME/mbsync
export EDITOR="emacsclient"
#export ALTERNATE_EDITOR="vim"
export GIT_EDITOR=$EDITOR
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

# Don't hash directories on the path a time, which allows new
# binaries in $PATH to be executed without rehashing.
setopt nohashdirs

# If a pattern for filename generation has no matches,
# delete the pattern from the argument list.
# Do not report an error unless all the patterns in a command have no matches.
set -o CSH_NULL_GLOB

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^t' history-substring-search-up
bindkey '^n' history-substring-search-down

# Bind ctrl+n to show a list of the most recently modified files.
zstyle ':completion:most-recent-file:*' match-original both
zstyle ':completion:most-recent-file:*' file-sort modification
zstyle ':completion:most-recent-file:*' file-patterns '*:all\ files'
zstyle ':completion:most-recent-file:*' hidden all
zstyle ':completion:most-recent-file:*' completer _files
zle -C most-recent-file menu-complete _generic
bindkey "^w" most-recent-file

bindkey '^e' edit-command-line

export GPG_TTY=$(tty)
export GPG_AGENT_INFO=$HOME/.gnupg/S.gpg-agent

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
