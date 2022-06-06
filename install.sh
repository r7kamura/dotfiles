#!/bin/bash
set -euo pipefail

ln -fs ~/dotfiles/.bashrc ~/.bashrc
ln -fs ~/dotfiles/.tigrc ~/.tigrc

suto apt update
sudo apt install tig --yes
