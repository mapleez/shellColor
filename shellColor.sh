#!/bin/bash

# Editor : ez
# Date : 2018/1/9
# CHANGE : Display the remaining 2 styles.

## bash script with color in terminal
# echo -e \033[style;colorm : with style
# echo -e \033[colorm       : without style

## Styles (optional)
#  0 Normal Characters
#  1 Bold Characters
#  4 Underlined Characters
#  5 Blinking Characters

## Colors [Foreground 3, Background 4]
#  0 black
#  1 red
#  2 green
#  3 yellow
#  4 blue
#  5 magenta
#  6 cyan
#  7 white
#  9 reset

# The format of one color row (2 lines) : 
# Assume the BACK_COLOR code is x
#
# BACK_COLOR : \033[4xm\033[3*m\033[39;49m
#            : \033[1;4xm\033[3*m\033[0;39;49m
#


colors=( "blk" "red" "grn" "yel" "blu" "mag" "cyn" "wht" )
color_num=${#colors[@]}

## Print table
# Each row will have 4 lines : Normal, Bold, Underlined and Blinking style, and will represent a background colors
# Each column is a foreground color
for (( row = -1; row < $color_num; row++ )); do
    # Start line
    if [ $row -eq -1 ]; then
        # Start default line (line -1)
        # Initialize 4 style on each line
        line1="DFT :  ";
        line2="    : \033[1m ";
        line3="    : \033[4m ";
        line4="    : \033[5m ";
    else
        # Start colored line (line 0-7)
        # Search color name
        name=${colors[row]}

        # Initialize lines start and foreground (4* color)
        # Initialize 4 style on each line
        line1="$(echo $name | tr 'a-z' 'A-Z') : \033[4${row}m ";
        line2="    : \033[1;4${row}m ";
        line3="    : \033[4;4${row}m ";
        line4="    : \033[5;4${row}m ";
    fi

    # Fill lines's columns
    for (( color = 0; color < $color_num; color++ )); do
        # Compose column with color name with right color
        column="  \033[3${color}m${colors[color]}  "
        line1+=$column;
        line2+=$column;
				line3+=$column;
				line4+=$column;
    done

    # Reset settings (style, foreground (3*) and background (4*))
    line1+=" \033[39;49m :"; # reset only colors
    line2+=" \033[0;39;49m :"; # reset colors and style
    line3+=" \033[0;39;49m :"; # reset colors and style
    line4+=" \033[0;39;49m :"; # reset colors and style

    # Print separator and line
    echo -e "    --------------------------------------------------------------"
    echo -e "$line1"
    echo -e "$line2"
    echo -e "$line3"
    echo -e "$line4"
done
echo -e "    --------------------------------------------------------------"
