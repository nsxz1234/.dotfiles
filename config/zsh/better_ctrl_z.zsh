function better-ctrl-z () {
if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
else
    zle push-input
fi
}

zle -N better-ctrl-z
bindkey '^Z' better-ctrl-z
