#!/bin/bash
set -euo pipefail

dotfiles_directory="$(dirname $0)"
ln -fs ${dotfiles_directory}/.bashrc ~/.bashrc
ln -fs ${dotfiles_directory}/.tigrc ~/.tigrc

sudo apt-get update
sudo apt-get install --yes \
  curl \
  peco \
  tig

echo 'EDITOR="code --wait"' >> ~/.bashrc
