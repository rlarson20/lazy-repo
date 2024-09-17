#!/usr/bin/env bash

if [ $# -ne 1 ]; then
	./gather-repos.sh | fzf --prompt="lazy-repo> " --preview="gh repo view {}"
	exit 0
fi

cat $1 | fzf --prompt="lazy-repo> " --preview="gh repo view {}"
exit 0
