#!/usr/bin/env bash
set -e

tempfile=/tmp/dotfiles.zip
workspace=/tmp/dotfiles

# Download zipped installer
curl -LSfs -o ${tempfile} https://github.com/r7kamura/dotfiles/archive/master.zip

# Unzip installer into workspace
unzip -oq ${tempfile} -d ${workspace}

# Run installer
${workspace}/dotfiles-master/bin/install

# Cleanup
rm -rf ${tempfile} ${workspace}
