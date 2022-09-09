# vim:ft=sh:

### BEGIN STRIPE
# All Stripe related shell configuration
# is at ~/.stripe/shellinit/bashrc and is
# persistently managed by Chef. You shouldn't
# remove this unless you don't want to load
# Stripe specific shell configurations.
#
# Feel free to add your customizations in this
# file (~/.bashrc) after the Stripe config
# is sourced.
[ -f ~/.stripe/shellinit/bashrc ] && source ~/.stripe/shellinit/bashrc
### END STRIPE

# alias
alias vim='nvim'
alias ll='ls -l'
alias grep='grep --color=auto'
alias fcd='cd $(fzf)'
alias fvim='nvim $(fzf)'
alias subl='open -a /Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text'
alias co="$HOME/.toggle_color.sh"
alias cor="$HOME/.toggle_color.sh -r"
alias cof="$HOME/.toggle_color.sh -f"
alias ta='touch ~/alacritty.yml'
alias config="/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME"
alias config-co='curl -L http://bit.do/e3Hqx | /bin/bash'

# bash-sensible (https://github.com/mrzool/bash-sensible/blob/master/sensible.bash)

## Prevent file overwrite on stdout redirection
## # Use `>|` to force redirection to an existing file
set -o noclobber

## Enable history expansion with space
## E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

## Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

## SMARTER TAB-COMPLETION (Readline bindings) ##

## Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

## Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

## Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

## on menu-complete, first display the common prefix, then cycle through the
# options when hitting TAB
bind "set menu-complete-display-prefix on"

## Save multi-line commands as one command
shopt -s cmdhist

## Enable incremental history search with up/down arrows (also Readline goodness)
## Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

## Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
## Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
## Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# environment

export CLICOLOR=1
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

## rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

## binstubs
export PATH=.binstubs:$PATH

## history
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups
## Use standard ISO 8601 timestamp
## %F equivalent to %Y-%m-%d
## %T equivalent to %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '

if ! echo "$PROMPT_COMMAND" | grep -q history; then
  export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
fi

# ykman
# For compilers to find readline you may need to set:
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"
# For pkg-config to find readline you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"

# go path
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export PATH=$PATH:$(go env GOPATH)/bin

export TERM=xterm-256color

# source scripts -----------------------------------------------------------#{{{

# bash completion
# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# colors script
# shellcheck disable=SC1090
# [[ -s "$HOME/.colors.bash" ]] && source "$HOME/.colors.bash"

# shellcheck disable=SC1090
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Local config
# shellcheck disable=SC1090
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# shellcheck disable=SC1090
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="node_modules/.bin:$PATH"

# git alias -----------------------------------------------------------
alias gb='git branch'
# __git_complete gb _git_branch
alias gbc="git branch | grep -v master | xargs git branch -D"
alias gco='git checkout'
alias gro='git rebase origin/master'
# __git_complete gco _git_checkout
alias gap='git add -p'
alias gcam='git commit -a -m'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gs='git status'
alias gfp='git fetch -p'
alias glg='git lg'
alias glg1='git lg1'
alias glg2='git lg2'
alias glg3='git lg3'=
alias glp='git log --pretty=oneline | head'
alias gd='git diff'
# __git_complete gd _git_diff
alias gdm='git diff master'
alias gds='git diff --staged'
alias hc='hub compare'
alias hpr='hub pull-request'

gp() {
  if [[ $# -gt 0 ]]; then
    git push "$@"
  else
    git push --set-upstream origin "$(git rev-parse --abbrev-ref HEAD)"
  fi
}
alias lgp='./scripts/bin/lint && gp'
alias gpf='gp -f'

# PS1 -------------------------------------------------------------------------

# shellcheck disable=SC2154
GIT_PROMPT_CLEAN="\033[0;32m[✔]\033[0;00m"
# shellcheck disable=SC2154
GIT_PROMPT_DIRTY="\033[0;31m[✗]\033[0;00m"
# shellcheck disable=SC2154
GIT_PROMPT_NOSTASH=""

function parse_git_dirty () {
  echo ""
  # if [[ $(git diff --stat) != '' ]]; then
  #   echo -e "$GIT_PROMPT_DIRTY"
  # else
  #   echo -e "$GIT_PROMPT_CLEAN"
  # fi
}

function git_branch_name() {
  echo -e "\033[1;35m$(git symbolic-ref HEAD 2> /dev/null | sed -e "s/refs\/heads\///")\033[0;00m"
}

function git_prompt_info() {
  # shellcheck disable=SC2155
  local ref="$(command git symbolic-ref -q HEAD 2>/dev/null)"
  if [ -n "$ref" ]; then
    echo -e " \033[1;35m\ue0a0$(git_branch_name)\033[1;35m $(parse_git_dirty)\033[0;00m"
  fi
}

function rbenv_prompt_info() {
  if which rbenv > /dev/null; then
    echo -e " \033[1;31m\ue739 $(rbenv version-name)\033[0;00m"
  fi
}

function pyenv_prompt_info() {
  if which pyenv > /dev/null; then
    if [ ! -f "$PWD/Gemfile" ] && [ ! -f "$PWD/mix.exs" ] && [ ! -f "$PWD/project.clj" ] ; then
      echo -e " \033[1;36m\uf81f $(pyenv version-name)\033[0;00m"
    fi
  fi
}

ARROWS="\[\033[0;31m\]"$'\u227b'"\[\033[0;35m\]"$'\u227b'"\[\033[0;34m\]"$'\u227b'
PS1="\033[1;34m➜ \033[1;33m\w\$(rbenv_prompt_info)\$(pyenv_prompt_info)\$(git_prompt_info)\n${ARROWS} \[\033[0;00m\]"
export PS1

# fzf -------------------------------------------------------------------------
ag() {
  if which rg > /dev/null; then
    rg --color always --vimgrep --sort-files "$@" | less
  elif which ag > /dev/null; then
    ag "$@"
  else
    ack "$@"
  fi
}

if which fd > /dev/null; then
  export FZF_DEFAULT_COMMAND="fd --type f"
elif which rg > /dev/null; then
  export FZF_DEFAULT_COMMAND="rg --hidden --glob '!.git/*' --files"
fi

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# c - browse chrome history
c() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

# ripper tags -------------------------------------------------------------------------
rtags() {
  [[ -f ./tags ]] && rm ./tags && echo 'rm ./tags'
  echo 'running ripper-tags'
  find . \( -name 'build' -o -name 'log' -o -name 'migrations' -o -name 'node_modules' -o -name 'target' -o -name 'test' \) -prune -o -name '*.rb' -print0 | xargs -0 -P 6 -n 3000 ripper-tags -f - | LC_ALL=C sort -u --radixsort >> tags
}
