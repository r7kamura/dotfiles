#!/usr/bin/env bash

cd /tmp
curl -LSfs -O https://github.com/r7kamura/dotfiles/archive/master.zip
unzip -q master.zip
rm master.zip
dotfiles-master/bin/install
rm -rf dotfiles-master
