# allow completion of hidden files
_comp_options+=(globdots)

fpath=(/usr/share/zsh/site-functions $fpath)
fpath=($HOME/.local/share/zsh/site-functions $fpath)

source $ZDOTDIR/plugins.zsh

autoload -U colors && colors # Enable colors in prompt

# initialize completions
autoload -Uz compinit
compinit

# 一定要在compinit之后, 否则有的插件没用
zsh_add_plugin    "zdharma-continuum/fast-syntax-highlighting"
zsh_add_plugin    "zsh-users/zsh-autosuggestions"
zsh_add_plugin    "zsh-users/zsh-completions"

setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt LIST_PACKED
setopt AUTO_CD
setopt RM_STAR_WAIT
setopt CORRECT                  # command auto-correction
setopt COMPLETE_ALIASES
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt AUTOPARAMSLASH            # tab completing directory appends a slash
setopt SHARE_HISTORY             # Share your history across all your terminal windows
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt AUTO_PUSHD                # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS         # Do not store duplicates in the stack.
setopt PUSHD_SILENT              # Do not print the directory stack after pushd or popd.

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

# Enable keyboard navigation of completions in menu
# (not just tab/shift-tab but cursor keys as well):
zstyle ':completion:*' menu select
zmodload zsh/complist

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=241"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export TERMINAL='foot'
export EDITOR='nvim'
export VISUAL='nvim'
# zig
export PATH=$PATH:~/zig
# flutter
export CHROME_EXECUTABLE=/usr/bin/brave
export PATH=~/flutter/bin:$PATH
export PATH=~/Android/Sdk/platform-tools:$PATH
# cargo
export PATH=$PATH:~/.cargo/bin
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# nnn
export NNN_PLUG='f:fzopen;v:imgview'
export NNN_BMS=".:$HOME/.dotfiles;c:$HOME/.config"
export NNN_TRASH=1
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"
BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn -exd "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}

# fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS="--reverse \
--cycle"

eval "$(zoxide init zsh)"

alias ssh="env TERM=xterm-256color ssh"
alias ls="ls --color=auto --hyperlink=auto $@"
alias l="eza --long --all --git --color=always --group-directories-first --icons $@"
alias lt="eza --icons --all --color=always -T $@"
alias e='nvim'
alias lg='lazygit'
alias ra='ranger'
alias grep='grep --color'

# Emacs keybindings
bindkey -e
# ^g to open lazygit (below oh-my-zsh)
bindkey -s '^g' 'lazygit\n'

eval "$(starship init zsh)"

# bun completions
[ -s "/home/nsxz/.bun/_bun" ] && source "/home/nsxz/.bun/_bun"

# foot
function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd
