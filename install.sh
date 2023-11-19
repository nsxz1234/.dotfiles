#!/bin/sh

dotfiles=$(pwd)

ln -sf $dotfiles/.zprofile ~/.zprofile
ln -sf $dotfiles/.xkb ~/

mkdir -p ~/.config
for file in $dotfiles/config/*; do
  ln -sf $file ~/.config/
done

sudo cp -r wayland-sessions /usr/local/share/
