#!/bin/bash
set -euo pipefail

ln -fs ~/dotfiles/.bashrc ~/.bashrc
ln -fs ~/dotfiles/.tigrc ~/.tigrc

apt update
apt install tig --yes
