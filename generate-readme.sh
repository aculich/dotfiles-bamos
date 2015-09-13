#!/bin/bash

set -x -e +H
cd "$(dirname "$0")"

cat>README.md<<EOF
<!--

This README is auto-generated with generate-readme.sh
Please add changes there.

-->




















# About
This repository contains configuration files I use on Mac and Linux systems
which have been inspired by the rest of the dotfiles community.
This \`README\` has been automatically generated by
[generate-readme.sh][generate-readme.sh] on $(date).
The following screenshots are automatically generated by
the [screenshots/generate.sh][screenshot-gen] script
by taking screenshots in an [X virtual framebuffer][xvfb].

[screenshot-gen]: https://github.com/bamos/dotfiles/blob/master/screenshots/generate.sh
[xvfb]: http://www.x.org/archive/X11R7.7/doc/man/man1/Xvfb.1.xhtml
[generate-readme.sh]: https://github.com/bamos/dotfiles/blob/master/generate-readme.sh
EOF

#./screenshots/generate.sh

SS_PREFIX=https://raw.githubusercontent.com/bamos/dotfiles/master/screenshots
for F in {vim,emacs,zsh,mutt,screen,tmux}; do
  echo -e "## $F\n![]($SS_PREFIX/$F.png)" >> README.md
done

cat>>README.md<<EOF
# Installation

Clone this repo with git's \`--recursive\` flag to obtain all the submodules.
Run [bootstrap.sh][bootstrap.sh] to symlink all of the dotfiles in this repo
to the home directory and install vim plugins.
This shell script will possibly be migrated to [GNU Stow][stow] in the future

[bootstrap.sh]: https://github.com/bamos/dotfiles/blob/master/bootstrap.sh
[stow]: http://www.gnu.org/software/stow/


# Custom shell functions and aliases.
See the [.funcs][funcs] directory.

[funcs]: https://github.com/bamos/dotfiles/blob/master/.funcs

# What programs do these configure?
<!-- TODO: Make this easier to maintain. -->
+ Misc Linux config: [.xinitrc](/.xinitrc), [.Xmodmap](/.Xmodmap),
  [.Xresources](/.Xresources)
+ [aria2](https://github.com/tatsuhiro-t/aria2): [.aria2](/.aria2)
+ [cmus](https://cmus.github.io/): [.cmus](/.cmus)
+ [conky](https://wiki.archlinux.org/index.php/Conky): [.conkyrc](/.conkyrc)
+ [emacs](https://www.gnu.org/software/emacs/): [.emacs.d](/.emacs)
+ [git](https://git-scm.com/): [.gitignore_global](/.gitignore_global)
+ [GNU aspell](aspell.net): [.aspell.en.pws](/.aspell.en.pws)
+ [GPG](https://www.gnupg.org): [.gnupg](/.gnupg)
+ [homebrew](http://brew.sh/): [.Brewfile](/.Brewfile)
+ [i3wm](https://i3wm.org/): [.i3](/.i3)
+ [ispell](https://www.gnu.org/software/ispell/): [.ispell_english](/.ispell_english)
+ [mjolnir](https://github.com/sdegutis/mjolnir): [.mjolnir](/.mjolnir)
+ [mpv](http://mpv.io): [.mpv](/.mpv)
+ [mutt](http://www.mutt.org): [.mutt](/.mutt) and [.muttrc](/.muttrc)
+ [sbt](http://www.scala-sbt.org): [.sbt](/.sbt)
+ [screen](https://www.gnu.org/software/screen/): [.screenrc](/.screenrc)
+ [tmux](https://tmux.github.io/): [.tmux.conf](/.tmux.conf) and
  [.tmux-osx.conf](/.tmux-osx.conf)
+ [vim](http://www.vim.org/): [.vim](/.vim)
+ [xmonad](http://xmonad.org): [.xmonad](/.xmonad)
+ [yaourt](https://github.com/archlinuxfr/yaourt): [.yaourt](/.yaourt)
+ [zsh](http://www.zsh.org): [.zshrc](/.zshrc), [.zshenv](/.zshenv),
  [.zsh-custom](/.zsh-custom), [.funcs](/.funcs), and [.oh-my-zsh](/.oh-my-zsh).

cat>>README.md<<EOF
# Similar Projects and Inspiration
There are many approaches to managing dotfiles on GitHub
that have inspired this repository, and this project
uniquely adds automatic screenshot generation.
The following list was generated on $(date +%Y-%m-%d) and
shows a subset of related projects.
[The dotfiles page on the Arch Linux Wiki](https://wiki.archlinux.org/index.php/Dotfiles)
is another good resource.

EOF

# Reference:
# https://github.com/bamos/python-scripts/blob/master/python3/github-repo-summary.py.
# Dependency: https://github.com/jacquev6/PyGithub

github-repo-summary.py \
  mathiasbynens/dotfiles \
  robbyrussell/oh-my-zsh \
  spf13/spf13-vim \
  tpope/tpope \
  justone/dotfiles \
  holman/dotfiles \
  gf3/dotfiles \
  joedicastro/dotfiles \
  ryanb/dotfiles \
  skwp/dotfiles \
  thoughtbot/dotfiles \
  cowboy/dotfiles \
  sontek/dotfiles \
  garybernhardt/dotfiles \
  paulmillr/dotfiles \
  rmm5t/dotfiles \
  ssaunier/dotfiles \
  windelicato/dotfiles \
  pengwynn/dotfiles \
  nelstrom/dotfiles \
  ocodo/.emacs.d \
  terhechte/emacs.d \
  themattman/dotfiles \
  themattman/utilities \
  vicfryzel/xmonad-config \
  zweifisch/dotfiles \
  >> README.md
