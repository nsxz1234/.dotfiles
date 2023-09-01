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
zsh_add_plugin    "zsh-users/zsh-syntax-highlighting"
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

export EDITOR='nvim'
export VISUAL='nvim'
# zig
export PATH=$PATH:~/zig
# flutter
export CHROME_EXECUTABLE=/usr/bin/brave
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PATH=~/flutter/bin:$PATH
export PATH=~/Android/Sdk/platform-tools:$PATH
# cargo
export PATH=$PATH:~/.cargo/bin
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(zoxide init zsh)"

alias ls="ls --color=auto --hyperlink=auto $@"
alias l="exa --long --all --git --color=always --group-directories-first --icons $@"
alias lt="exa --icons --all --color=always -T $@"
alias e='nvim'
alias lg='lazygit'
alias ra='ranger'
alias n="nnn -ex"
alias ez="${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc"
alias grep='grep --color'

# ^g to open lazygit (below oh-my-zsh)
bindkey -s '^g' 'lazygit\n'
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^e' autosuggest-accept

eval "$(starship init zsh)"

# bun completions
[ -s "/home/nsxz/.bun/_bun" ] && source "/home/nsxz/.bun/_bun"
