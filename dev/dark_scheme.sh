# munge vimrc
sed -i -e 's/^set background=light$/set background=dark/g' ~/.vimrc
sed -i -e 's/^hi! CursorLine cterm=NONE ctermbg=187 ctermfg=94 guibg=#3c3d3a guifg=white$/hi! CursorLine cterm=NONE gui=NONE ctermfg=NONE guifg=NONE ctermbg=237 guibg=#3c3d3a/g' ~/.vimrc
sed -i -e "s/'colorscheme': 'solarized',$/'colorscheme': 'PaperColor',/g" ~/.vimrc

# replace alacritty.yml
cp ~/alacritty/alacritty_solarized_ubuntu.yml ~/.alacritty.yml

# munge tmux.conf
sed -i -e 's/^setw -g window-status-current-bg colour144$/setw -g window-status-current-bg colour66/g' ~/.tmux.conf
sed -i -e "s/^setw -g window-status-current-format ' #I#\[fg=colour250\]:#\[fg=colour230\]#W#\[fg=colour82\]#F '$/setw -g window-status-current-format ' #I#\[fg=colour250\]:#\[fg=colour255\]#W#\[fg=colour82\]#F '/g" ~/.tmux.conf
sed -i -e 's/^setw -g window-status-current-bg colour144$/setw -g window-status-current-bg colour66/g' ~/.tmux.conf
sed -i -e 's/^setw -g window-status-bg colour144/setw -g window-status-bg colour237/g' ~/.tmux.conf
sed -i -e "s/^setw -g window-status-format ' #I#\[fg=colour230\]:#\[fg=colour230\]#W#\[fg=colour230\]#F '$/setw -g window-status-format ' #I#\[fg=colour237\]:#\[fg=colour250\]#W#\[fg=colour244\]#F '/g" ~/.tmux.conf
sed -i -e "s/^set -g status-right '#\[fg=colour230,bg=colour144,bold\] %d\/%m #\[fg=colour230,bg=colour149,bold\] %H:%M:%S '$/set -g status-right '#\[fg=colour233,bg=colour241,bold\] %m\/%d #\[fg=colour233,bg=colour246,bold\] %H:%M:%S '/g" ~/.tmux.conf

