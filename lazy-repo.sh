#!/usr/bin/env bash

lazy_repo_gather() {
	location_of_installed_plugins="$HOME/.local/share/nvim/lazy"
	cd "$location_of_installed_plugins"
	rg --only-matching --no-filename --max-count=1 "http.*" ./*/.git/config | sed 's/.git$//' | sed 's/.*com\///' | sort -i
}

directory_repo_gather() {
	repo_location=$2
	cd "$repo_location"
	rg --only-matching --no-filename ".*github\.com.*" | sort -iu | sed 's/.*com\///'
}

directory_search() {
	directory_repo_gather "$@" | fzf --prompt="lazy-repo> " --preview="gh repo view {}"
}

lazy_plugins() {
	lazy_repo_gather | fzf --prompt="lazy-repo> " --preview="gh repo view {}"
}

file_search() {
	cat "$2" | fzf --prompt="lazy-repo> " --preview="gh repo view {}"
}
while getopts ":dlf" option; do
	case $option in
	d) # directory search
		directory_search "$@"
		exit 0
		;;
	l) # lazy plugin search
		lazy_plugins
		exit 0
		;;
	f) # file repo search
		file_search "$@"
		exit 0
		;;
	?) #invalid args
		echo "Invalid arguments, sorry."
		;;
	esac
done
echo "No arguments, please use -d for directory search, -l for lazy plugin search, -f for file search"
