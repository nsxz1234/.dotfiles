export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export DOTFILES=$HOME/.dotfiles

export MANPATH="$HOME/.local/share/man:/usr/share/man:"
export PATH=$PATH:~/.local/bin

export TERMINAL=ghostty
export EDITOR=nvim
export VISUAL=nvim

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

# export XKB_DEFAULT_LAYOUT=us

# 打不开虚拟机 一些程序鼠标很小
# export QT_QPA_PLATFORM=wayland

# wayland环境java程序需要配置
# export _JAVA_AWT_WM_NONREPARENTING=1

# archlinux downgrade
export DOWNGRADE_FROM_ALA=1

export MOZ_ENABLE_WAYLAND=1

# flutter
export PATH=~/flutter/bin:$PATH
export PATH=$PATH:~/Android/Sdk/platform-tools
export PATH=$PATH:~/Android/Sdk/emulator/
export ANDROID_AVD_HOME=$XDG_CONFIG_HOME/.android/avd/
export CHROME_EXECUTABLE=/usr/bin/chromium
