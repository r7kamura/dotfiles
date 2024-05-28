#!/bin/bash
set -euo pipefail

dotfiles_directory="$(cd "$(dirname "$0")"; pwd -P)"
ln -fs ${dotfiles_directory}/.bashrc ~/.bashrc
ln -fs ${dotfiles_directory}/.gitconfig ~/.gitconfig
ln -fs ${dotfiles_directory}/.tigrc ~/.tigrc
source ~/.bashrc

sudo apt-get update
sudo apt-get install --yes \
  curl \
  peco \
  ssh \
  tig

(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y
