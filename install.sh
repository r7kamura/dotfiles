#!/bin/bash
set -euo pipefail

dotfiles_directory="$(cd "$(dirname "$0")"; pwd -P)"
ln -fs ${dotfiles_directory}/.bashrc ~/.bashrc
ln -fs ${dotfiles_directory}/.tigrc ~/.tigrc

sudo apt-get update
sudo apt-get install --yes \
  curl \
  peco \
  tig

echo 'EDITOR="code --wait"' >> ~/.bashrc
