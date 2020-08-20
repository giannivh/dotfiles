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

MSG_ID="9910493"



function showNotification() {
  if command -v dunstify &>/dev/null; then
      notify="dunstify --replace ${MSG_ID}"
  else
      notify="notify-send"
  fi
  $notify --appname "CPU Usage" \
          --urgency normal \
          --icon indicator-cpufreq \
          "CPU Usage" \
          "\n$(ps axch -o cmd:30,pcpu k -pcpu | head | awk '$0=$0"%"')" &
}

function printUsage() {
  curUsage=$(mpstat 1 1 | awk '$3 ~ /CPU/ { for(i=1;i<=NF;i++) { if ($i ~ /%idle/) field=i } } $3 ~ /all/ { printf("%d",100 - $field) }')
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
  echo "${formatUnderline}${formatIcon} ${formatText}${curUsage}%${COLOR_END}${UNDERLINE_END}"
}

case "$1" in
    --show)
        showNotification
        ;;
    *)
        printUsage
        ;;
esac
