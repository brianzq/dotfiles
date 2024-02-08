#! /bin/bash

# Toggle alacritty color scheme

DEFAULT_LIGHT_SCHEME=solarized-light
DEFAULT_DARK_SCHEME=oceanicnext
FAVORITE_SCHEMES="gruvbox-dark-hard\nporple\nmateria\nonedark\nhopscotch\natelier-savanna-light\natelier-estuary-light"
ALACRITTY_CONFIG=$HOME/.alacritty.toml

all_schemes() {
    grep "# colors__[a-zA-Z0-9_-]*__\(dark\|light\).primary =" "$ALACRITTY_CONFIG" | gsed "s/# colors__\([a-zA-Z0-9_-]*\)__\(light\|dark\).primary =.*/\1/"
}

get_current_scheme() {
    grep "^# \[colors\] [a-zA-Z0-9_-]* (\(dark\|light\))" "$ALACRITTY_CONFIG" | gsed "s/# \[colors\] \([a-zA-Z0-9_-]*\) (.*/\1/"
}

get_current_mode() {
    grep "^# \[colors\] [a-zA-Z0-9_-]* (\(dark\|light\))" "$ALACRITTY_CONFIG" | gsed "s/.*(\([a-z]*\))$/\1/"
}

get_target_mode() {
    grep "^# colors__$1__\(dark\|light\).primary" "$ALACRITTY_CONFIG" | gsed "s/^# colors__$1__\(dark\|light\)\.primary.*/\1/"
}

use_scheme() {
    current_scheme=$(get_current_scheme)
    current_mode=$(get_current_mode)
    target_scheme=$1
    target_mode=$(get_target_mode "$target_scheme")
    gsed -i "s/^# \[colors\] \(${current_scheme} (${current_mode})\)$/# [colors] ${target_scheme} (${target_mode})/" "$ALACRITTY_CONFIG"
    gsed -i "s/^colors.\(bright\|cursor\|normal\|primary\) = \(.*\)$/# colors__${current_scheme}__${current_mode}.\1 = \2/" "$ALACRITTY_CONFIG"
    gsed -i "s/^# colors__${target_scheme}__${target_mode}.\(bright\|cursor\|normal\|primary\) = \(.*\)$/colors.\1 = \2/" "$ALACRITTY_CONFIG"
}


if [ -z "$1" ]; then
    mode=$(get_current_mode)
    if [ "$mode" == 'dark' ]; then
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
        echo -e "Bad input. Valid schemes: [$(echo "$valid_schemes" | tr ' ' "\n")]"
        exit 1
    fi
fi

use_scheme "$target"
echo "Enjoy ${target}"
sleep 0.1
touch "$ALACRITTY_CONFIG"
exit
