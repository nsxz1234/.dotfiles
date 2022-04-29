# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

plugins=(
  git
)

# zsh
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# fzf (after zsh)
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

alias l="ls -la"
alias v='nvim'
alias lg='lazygit'
alias ra='ranger'
alias n="n -e"

# ^g to open lazygit
bindkey -s '^g' 'lazygit\n'

# flutter
export CHROME_EXECUTABLE=/usr/bin/brave
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PATH=~/flutter/bin:$PATH
export PATH=~/Android/Sdk/platform-tools:$PATH

# cargo
export PATH=$PATH:~/.cargo/bin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
