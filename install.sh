#!/bin/sh

dotfiles=$(pwd)

ln -sf $dotfiles/.zprofile ~/.zprofile

mkdir -p ~/.config
for file in $dotfiles/config/*; do
  ln -sf $file ~/.config/
done
