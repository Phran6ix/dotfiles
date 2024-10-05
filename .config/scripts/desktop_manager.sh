#!/usr/bin/env sh
# AUTHOR: gotbletu (@gmail|twitter|youtube|github|lbry)
#         https://www.youtube.com/user/gotbletu
# DESC:   launch app(s) with fzf like dmenu/rofi
# DEPEND: fzf sed coreutils findutils xdg-utils util-linux

desktop_file() {  
  # find in the folders files that end with .desktop extensions
  find /usr/share/applications -name "*.desktop" 2>/dev/null \
  && find /usr/local/share/applications -name "*.desktop" 2>/dev/null \
  && find "$HOME/.local/share/applications" -name "*.desktop" 2>/dev/null \
  && find /var/lib/flatpak/exports/share/applications -name "*.desktop" 2>/dev/null \
  && find "$HOME/.local/share/flatpak/exports/share/applications" -name "*.desktop" 2>/dev/null
}

selected="$(desktop_file | sed 's/.desktop//g' | sort | ~/.fzf/bin/fzf -e -i -m --reverse --delimiter / --with-nth -1)"
# if no desktop app, exit 
[ -z "$selected" ] && exit
# enter  $HOME 
cd || return
command -v dex >/dev/null 2>&1 || { echo "dex is not installed"; exit 1; }
echo "$selected" | while read -r line ; do setsid dex "$line".desktop ; done
