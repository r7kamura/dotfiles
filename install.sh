#!/bin/bash
set -euo pipefail

ln -fs ~/dotfiles/.bashrc ~/.bashrc
ln -fs ~/dotfiles/.tigrc ~/.tigrc

# https://github.com/cli/cli/blob/866eccc202ec61134e5d7f24234ec1e50d6d2854/docs/install_linux.md
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

apt update
apt install --yes \
  gh \
  peco \
  tig
