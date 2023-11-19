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
export PATH=~/Android/Sdk/platform-tools:$PATH
export CHROME_EXECUTABLE=/usr/bin/chromium
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export TERMINAL=foot
export EDITOR=nvim
export VISUAL=nvim

export QT_SCALE_FACTOR=2

export GDK_DPI_SCALE=2

export XKB_DEFAULT_LAYOUT=us

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

# 打不开虚拟机 一些程序鼠标很小
export QT_QPA_PLATFORM=wayland

# wayland环境java程序需要配置
# export _JAVA_AWT_WM_NONREPARENTING=1

# archlinux downgrade
export DOWNGRADE_FROM_ALA=1

export MOZ_ENABLE_WAYLAND=1
