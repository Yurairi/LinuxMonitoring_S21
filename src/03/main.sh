#!/bin/bash

# Check if there are exactly 4 parameters
if [ "$#" -ne 4 ]; then
    echo "Error: Please provide 4 parameters. Example: script03.sh 1 3 4 5"
    exit 1
fi

# Function to apply color to text
apply_color() {
    local text_l="$1"
    local bg_color_l="$2"
    local font_color_l="$3"
    local text_r="$4"
    local bg_color_r="$5"
    local font_color_r="$6"

    echo -e "\e[48;5;${bg_color_l}m\e[38;5;${font_color_l}m$text_l:\e[0m \e[0m\e[48;5;${bg_color_r}m\e[38;5;${font_color_r}m$text_r\e[0m"
}

# Define color codes
bg_title_color=${1}
font_title_color=${2}
bg_value_color=${3}
font_value_color=${4}

# Check if the color codes are valid
if [ "$bg_title_color" == "$font_title_color" ] || [ "$bg_value_color" == "$font_value_color" ]; then
    echo "Error: Background and font color of the same column should not match."
    exit 1
fi

# Display information with specified colors
apply_color "HOSTNAME" "$bg_title_color" "$font_title_color" "$(hostname)" "$bg_value_color" "$font_value_color"

apply_color "TIMEZONE" "$bg_title_color" "$font_title_color" "$(timedatectl | grep "Time zone" | awk '{print $3, $4, $5}')" "$bg_value_color" "$font_value_color"

apply_color "USER" "$bg_title_color" "$font_title_color" "$(whoami)" "$bg_value_color" "$font_value_color"

apply_color "OS" "$bg_title_color" "$font_title_color" "$(lsb_release -d | cut -f2-)" "$bg_value_color" "$font_value_color"

apply_color "DATE" "$bg_title_color" "$font_title_color" "$(date +'%d %b %Y %T')" "$bg_value_color" "$font_value_color"

apply_color "UPTIME" "$bg_title_color" "$font_title_color" "$(uptime -p)" "$bg_value_color" "$font_value_color"

apply_color "UPTIME_SEC" "$bg_title_color" "$font_title_color" "$(cat /proc/uptime | awk '{print $1}')" "$bg_value_color" "$font_value_color"

apply_color "IP" "$bg_title_color" "$font_title_color" "$(ip -4 addr show | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1 | head -n 1)" "$bg_value_color" "$font_value_color"

apply_color "MASK" "$bg_title_color" "$font_title_color" "$(ip -4 addr show | grep 'inet ' | awk '{print $2}' | cut -d'/' -f2 | head -n 1)" "$bg_value_color" "$font_value_color"

apply_color "GATEWAY" "$bg_title_color" "$font_title_color" "$(ip route | grep default | awk '{print $3}')" "$bg_value_color" "$font_value_color"

apply_color "RAM_TOTAL" "$bg_title_color" "$font_title_color" "$(free -h --giga | awk '/Mem:/ {print $2}')" "$bg_value_color" "$font_value_color"

apply_color "RAM_USED" "$bg_title_color" "$font_title_color" "$(free -h --giga | awk '/Mem:/ {print $3}')" "$bg_value_color" "$font_value_color"

apply_color "RAM_FREE" "$bg_title_color" "$font_title_color" "$(free -h --giga | awk '/Mem:/ {print $4}')" "$bg_value_color" "$font_value_color"

apply_color "SPACE_ROOT" "$bg_title_color" "$font_title_color" "$(df -h / | awk '/\// {print $2}')" "$bg_value_color" "$font_value_color"

apply_color "SPACE_ROOT_USED" "$bg_title_color" "$font_title_color" "$(df -h / | awk '/\// {print $3}')" "$bg_value_color" "$font_value_color"

apply_color "SPACE_ROOT_FREE" "$bg_title_color" "$font_title_color" "$(df -h / | awk '/\// {print $4}')" "$bg_value_color" "$font_value_color"