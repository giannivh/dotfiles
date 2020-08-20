#!/usr/bin/env bash

COLOR_TEXT="dfdfdf"
COLOR_NORMAL="73d216"
COLOR_WARNING="ffb52a"
COLOR_ALERT="d21616"
COLOR_END="%{F-}"

UNDERLINE_START="%{+u}"
UNDERLINE_END="%{-u}"

THRESHOLD_WARNING="50"
THRESHOLD_ALERT="75"

MSG_ID="9910494"



function showNotification() {
  if command -v dunstify &>/dev/null; then
      notify="dunstify --replace ${MSG_ID}"
  else
      notify="notify-send"
  fi
  $notify --appname "Memory Usage" \
          --urgency normal \
          --icon indicator-sensors-memory \
          "Memory Usage" \
          "$(free | grep Mem | awk '{printf("%.2fGi / %.2fGi", ($2-$7)/1024^2, $2/1024^2)}')\n\n$(ps axch -o cmd:30,pmem k -pmem | head | awk '$0=$0"%"')" &
}

function printUsage() {
  curUsage=$(free | grep Mem | awk '{printf("%.0f", ($2-$7)/$2 * 100.0)}')
  if [ "${curUsage}" -gt "${THRESHOLD_ALERT}" ]; then
    formatIcon="%{F#${COLOR_ALERT}}"
    formatText="${formatIcon}"
    formatUnderline="${UNDERLINE_START}%{u#${COLOR_ALERT}}"
  elif [ "${curUsage}" -gt "${THRESHOLD_WARNING}" ]; then
    formatIcon="%{F#${COLOR_WARNING}}"
    formatText="${formatIcon}"
    formatUnderline="${UNDERLINE_START}%{u#${COLOR_WARNING}}"
  else
    formatIcon="%{F#${COLOR_NORMAL}}"
    formatText="%{F#${COLOR_TEXT}}"
    formatUnderline=""
  fi
  echo "${formatUnderline}${formatIcon} ${formatText}${curUsage}%${COLOR_END}${UNDERLINE_END}"
}

case "$1" in
    --show)
        showNotification
        ;;
    *)
        printUsage
        ;;
esac
