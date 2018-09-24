#!/bin/sh

############################################################
##                                                        ##
## Neomutt notification                                   ##
##                                                        ##
## Author: Gianni Van Hoecke <gianni@giannivanhoecke.com> ##
## Date:   2018-09-24                                     ##
##                                                        ##
############################################################

app="Neomutt"
title="New Mail"
icon=~/.config/neomutt/neomutt.png
message="$1"

tput bel

case "$(uname -s)" in
  Darwin)
    terminal-notifier -title "$app" -subtitle "$title" -message "$message" -activate "com.googlecode.iterm2" -appIcon "$icon" &
    ;;
  *)
    notify-send --icon="$icon" "$title" "$message" &
    ;;
esac
