#! /bin/bash

# Toggle alacritty color scheme

DEFAULT_LIGHT_SCHEME=solarized-light
DEFAULT_DARK_SCHEME=oceanicnext
FAVORITE_SCHEMES="gruvbox-dark-hard\nporple\nmateria\nonedark\nhopscotch"

all_schemes() {
    grep "^colors__[a-zA-Z0-9_-]*__\(dark\|light\):$" $HOME/.alacritty.yml | gsed 's/colors__\([a-zA-Z0-9_-]*\)__\(light\|dark\):/\1/'
}

get_current_scheme() {
    grep '^colors: # [a-zA-Z0-9_-]* (\(dark\|light\))' $HOME/.alacritty.yml | gsed 's/.*: # \([a-zA-Z0-9_-]*\) (.*/\1/'
}

get_current_mode() {
    grep '^colors: # [a-zA-Z0-9_-]* (\(dark\|light\))' $HOME/.alacritty.yml | gsed 's/.*(\([a-z]*\))$/\1/'
}

__disable_active_scheme() {
    current_scheme=$(get_current_scheme)
    current_mode=$(get_current_mode)
    # echo "disabling active scheme $current_scheme..."
    gsed -i "s/^colors: # ${current_scheme} (${current_mode})$/colors__${current_scheme}__${current_mode}:/" $HOME/.alacritty.yml
    # echo "done"
}

__enable_target_scheme() {
    # echo "switching to $1..."
    gsed -i "s/^colors__\($1\)__\(light\|dark\):$/colors: # \1 (\2)/" $HOME/.alacritty.yml
    # echo -e "done.\nhappy hacking!"
}

use_scheme() {
    __disable_active_scheme && __enable_target_scheme $1
}


if [ -z "$1" ]; then
    scheme=$(get_current_scheme)
    mode=$(get_current_mode)
    if [ $mode == 'dark' ]; then
        target=$DEFAULT_LIGHT_SCHEME
    else
        target=$DEFAULT_DARK_SCHEME
    fi
elif [[ $1 == '-r' ]]; then
    target=$(all_schemes | shuf -n 1)
elif [[ $1 == '-f' ]]; then
    target=$(echo -e $FAVORITE_SCHEMES | shuf -n 1)
else
    valid_schemes=$(all_schemes)
    if [[ $1 == $(get_current_scheme) ]]; then
        echo "already using $1, no-op"
        exit

    elif all_schemes | grep -q "^$1$"; then
        target=$1
    else
        echo -e "Bad input. Valid schemes: [$(echo $valid_schemes | tr ' ' "\n")]"
        exit 1
    fi
fi

use_scheme $target
echo "Enjoy ${target}"
sleep 0.1
touch $HOME/alacritty.yml
exit
