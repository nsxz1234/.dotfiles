export GPG_TTY=$(tty)

# setopt ALWAYS_TO_END
# setopt AUTO_MENU
# setopt LIST_PACKED
# setopt AUTO_CD
# setopt RM_STAR_WAIT
# setopt CORRECT                  # command auto-correction
# setopt COMPLETE_ALIASES
# setopt APPEND_HISTORY
# setopt EXTENDED_HISTORY
# setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS  # when adding a new entry to history remove any currently present duplicate
# setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE  # don't record lines starting with a space in the history
# setopt HIST_REDUCE_BLANKS
# setopt HIST_SAVE_NO_DUPS
# setopt HIST_VERIFY
# setopt AUTOPARAMSLASH            # tab completing directory appends a slash
# setopt SHARE_HISTORY             # Share your history across all your terminal windows
# setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # essentially syncs history between shells
# setopt AUTO_PUSHD                # Push the current directory visited on the stack.
# setopt PUSHD_IGNORE_DUPS         # Do not store duplicates in the stack.
# setopt PUSHD_SILENT              # Do not print the directory stack after pushd or popd.

HISTFILE=$HOME/.local/share/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

fpath=(/usr/share/zsh/site-functions $fpath)
fpath=($HOME/.local/share/zsh/site-functions $fpath)
# initialize completions
autoload -Uz compinit
# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''
# Enable keyboard navigation of completions in menu
# (not just tab/shift-tab but cursor keys as well):
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# allow completion of hidden files
_comp_options+=(globdots)

eval "$(zoxide init zsh)"

# load aliases
source $ZDOTDIR/aliases.zsh

# colorful less
export LESS_TERMCAP_md=$'\e[01;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;90m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'
# man 手册支持彩色
export GROFF_NO_SGR=1

autoload -U colors && colors # Enable colors in prompt
eval "$(starship init zsh)"

# 一定要在compinit之后, 否则有的插件没用
source $ZDOTDIR/plugins.zsh
zsh_add_plugin    "zdharma-continuum/fast-syntax-highlighting"
zsh_add_plugin    "zsh-users/zsh-autosuggestions"
zsh_add_plugin    "zsh-users/zsh-completions"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=241"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

source $ZDOTDIR/better_ctrl_z.zsh

# Emacs keybindings
bindkey -e
# ^g to open lazygit (below oh-my-zsh)
bindkey -s '^g' 'lazygit\n'


# bun completions
[ -s "/home/nsxz/.bun/_bun" ] && source "/home/nsxz/.bun/_bun"


# fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS="--reverse \
--cycle"


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


# nnn
export NNN_PLUG='f:fzopen;v:imgview'
export NNN_BMS=".:$DOTFILES;c:$XDG_CONFIG_HOME"
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


# zig
export PATH=$PATH:~/zig


# cargo
export PATH=$PATH:~/.cargo/bin


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
