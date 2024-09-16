cat $1 | fzf --prompt="lazy-repo> " --preview="gh repo view {}"
