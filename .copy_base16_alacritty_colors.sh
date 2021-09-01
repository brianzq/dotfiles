# script to copy all color schems from base16-alacritty repo to ~/.alacritty.yaml
BASE16_ALACRITTY_COLORS_PATH=~/code/base16-alacritty/colors
ALACRITTY_YML=~/.alacritty.yml

file_names=$(ls $BASE16_ALACRITTY_COLORS_PATH | grep -v 256)
for file_name in $file_names
do
  color_name=$(echo $file_name | gsed "s/base16-\([a-z0-9-]*\).yml/\1/")
  if [[ -n $(echo $color_name | grep -e '-light') ]]
  then
    cat "${BASE16_ALACRITTY_COLORS_PATH}/${file_name}" | grep "^colors:$" | gsed "s/colors/colors__${color_name}__light/" >> $ALACRITTY_YML
    cat "${BASE16_ALACRITTY_COLORS_PATH}/${file_name}" | grep -v "^colors:$" | grep -v "draw_bold_text_with_bright_colors" >> $ALACRITTY_YML
  else
    cat "${BASE16_ALACRITTY_COLORS_PATH}/${file_name}" | grep "^colors:$" | gsed "s/colors/colors__${color_name}__dark/" >> $ALACRITTY_YML
    cat "${BASE16_ALACRITTY_COLORS_PATH}/${file_name}" | grep -v "^colors:$" | grep -v "draw_bold_text_with_bright_colors" >> $ALACRITTY_YML
  fi
done
