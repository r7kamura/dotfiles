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

# Install the latest gh binary.
VERSION=`curl "https://api.github.com/repos/cli/cli/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c2-`
echo $VERSION
curl -sSL https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz -o gh_${VERSION}_linux_amd64.ta
tar xvf gh_${VERSION}_linux_amd64.tar.gz
sudo cp gh_${VERSION}_linux_amd64/bin/gh /usr/local/bin/

echo 'EDITOR="code --wait"' >> ~/.bashrc
