#!/usr/bin/env bash

#
# -- settings
#

NOTIFICATIONS="yes"
MSG_ID="9910492" # Arbitrary but unique message id

#
# -- functions
#

function getProgressString() {
  ITEMS="$1" # the total number of items(the width of the bar)
  FILLED_ITEM="$2" # the look of a filled item 
  NOT_FILLED_ITEM="$3" # the look of a not filled item
  STATUS="$4" # the current progress status in percent

  # calculate how many items need to be filled and not filled
  FILLED_ITEMS=$(echo "((${ITEMS} * ${STATUS})/100 + 0.5) / 1" | bc)
  NOT_FILLED_ITEMS=$(echo "$ITEMS - $FILLED_ITEMS" | bc)

  # assemble the bar string
  msg=$(printf "%${FILLED_ITEMS}s" | sed "s| |${FILLED_ITEM}|g")
  msg=${msg}$(printf "%${NOT_FILLED_ITEMS}s" | sed "s| |${NOT_FILLED_ITEM}|g")
  echo "$msg"
}

function showNotification() {
  if command -v dunstify &>/dev/null; then
      notify="dunstify --replace ${MSG_ID}"
  else
      notify="notify-send"
  fi

  curBrightness=$(xbacklight)

  $notify --appname "Brightness Control" --urgency low --icon xfpm-brightness-lcd \
    "Brightness: ${curBrightness%.*}%" "$(getProgressString 10 "<b> </b>" " " "${curBrightness%.*}")" &
}

#
# -- pass arguments to xbacklight
#

xbacklight "$@"

#
# -- show notification if enabled
#

if [ $NOTIFICATIONS = "yes" ]; then showNotification; fi
