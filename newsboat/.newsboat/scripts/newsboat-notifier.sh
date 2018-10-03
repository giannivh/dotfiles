#!/usr/bin/env bash

notify -a "Newsboat" -t "New Articles" -m "$1" -i "$HOME/.newsboat/scripts/newsboat.png" &
