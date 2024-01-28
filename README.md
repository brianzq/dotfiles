# A bare repo for managing dotfiles
I use this repo to manage my dotfiles. These are the scripts I ran to set up this repo on my machine.
```
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local core.fsmonitor false
```

## Setup on a new laptop
```
# clone the repo
git clone --bare git@github.com:brianzq/cfg.git $HOME/.dotfiles

# set the alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# some additional configs to make things work
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local core.fsmonitor false
```
## Use the config
```
dotfiles pull
```

Since git doesn't overwrite existing files by default, if you want to overwrite all existing dotfiles on the new laptop with what's in this repo, run
```
dotfiles checkout --force
```
