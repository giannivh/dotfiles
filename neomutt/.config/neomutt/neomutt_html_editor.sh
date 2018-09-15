#!/bin/bash
vim "$@"
if [ -f "$1" ]; then
   sed -i -e '/<br>$/! s/$/<br>/g' "$1"
   exit 0
fi
exit 1
