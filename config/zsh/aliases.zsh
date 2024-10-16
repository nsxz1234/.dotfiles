alias ssh="env TERM=xterm-256color ssh"
alias ls="ls --color=auto --hyperlink=auto $@"
alias l="eza --long --all --git --color=always --group-directories-first --icons $@"
alias lt="eza --icons --all --color=always -T $@"
alias e='nvim'
alias lg='lazygit'
alias y='yazi'
alias grep='grep --color'
alias re='wf-recorder -g "$(slurp)" -f recording.mp4'
alias err='journalctl -b -p err'
alias cal='cal -3'
alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
alias ipv6="ip addr show | grep 'inet6 ' | cut -d ' ' -f6 | sed -n '2p'"

. /etc/os-release
case $ID in
        void)
                alias t='ydcv-rs'
                ;;
        *)
                alias t='ydcv'
                ;;
esac
