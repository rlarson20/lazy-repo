#!/usr/bin/env bash

# tldr: getting all nvim plugins installed currently
# only from lazy atm

location_of_installed_plugins="$HOME/.local/share/nvim/lazy"

cd "$location_of_installed_plugins"

rg --only-matching --no-filename --max-count=1 "http.*" ./*/.git/config | sed 's/.git$//' | sed 's/.*com\///' | sort -i
