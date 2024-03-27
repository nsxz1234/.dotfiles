export HOMEBREW_PIP_INDEX_URL=https://pypi.mirrors.ustc.edu.cn/simple #ckbrew
export HOMEBREW_API_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/api  #ckbrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles #ckbrew
eval $(/opt/homebrew/bin/brew shellenv) #ckbrew

export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export DOTFILES=$HOME/.dotfiles

export MANPATH="$HOME/.local/share/man:/usr/share/man:"
export PATH=$PATH:~/.local/bin
# zig
export PATH=$PATH:~/zig
# cargo
export PATH=$PATH:~/.cargo/bin
# flutter
export PATH=~/flutter/bin:$PATH
export PATH=$PATH:~/Android/sdk/platform-tools
export PATH=$PATH:~/Android/sdk/emulator/
export ANDROID_AVD_HOME=$XDG_CONFIG_HOME/.android/avd/
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export TERMINAL=ghostty
export EDITOR=nvim
export VISUAL=nvim
