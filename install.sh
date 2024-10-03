#!/bin/sh

dotfiles=$(pwd)

ln -sf $dotfiles/.zprofile ~/.zprofile
ln -sf $dotfiles/.xkb ~/

mkdir -p ~/.config
for file in $dotfiles/config/*; do
  ln -sf $file ~/.config/
done

sudo mkdir -p /usr/share/wayland-sessions/
sudo cp wayland-sessions/river-zsh.desktop /usr/share/wayland-sessions/
