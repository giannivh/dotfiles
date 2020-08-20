#!/usr/bin/env bash

COLOR_TEXT="dfdfdf"
COLOR_NORMAL="73d216"
COLOR_WARNING="ffb52a"
COLOR_ALERT="d21616"
COLOR_END="%{F-}"

UNDERLINE_START="%{+u}"
UNDERLINE_END="%{-u}"

THRESHOLD_WARNING="400"
THRESHOLD_ALERT="1000"



curUsage=$(sh "${HOME}/Scripts/youless-get-stats")



if [ -n "${curUsage}" ]; then
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
  echo "${formatUnderline}${formatIcon} ${formatText}${curUsage}W${COLOR_END}${UNDERLINE_END}"
else
  echo ""
fi
