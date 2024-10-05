#!/bin/bash

set_brightness() {
    xrandr --output LVDS-1 --brightness "$1"
}

increase_brightness() {
    current_brightness=$(xrandr --verbose | grep -i brightness | cut -f2 -d ' ')
    new_brightness=$(awk -v cur="$current_brightness" 'BEGIN{print cur + 0.1}')
    set_brightness "$new_brightness"
}

decrease_brightness() {
    current_brightness=$(xrandr --verbose | grep -i brightness | cut -f2 -d ' ')
    new_brightness=$(awk -v cur="$current_brightness" 'BEGIN{print cur - 0.1}')
    set_brightness "$new_brightness"
}

case "$1" in
    "increase")
        increase_brightness
        ;;
    "decrease")
        decrease_brightness
        ;;
    *)
        echo "Usage: $0 [increase|decrease]"
        exit 1
        ;;
esac
