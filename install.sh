#!/usr/bin/env bash
set -eo pipefail

tempfile=/tmp/dotfiles.zip
workspace=/tmp/dotfiles

# Download zipped installer
echo -n "[    ] Download Installer..."
curl -LSfs -o ${tempfile} https://github.com/r7kamura/dotfiles/archive/master.zip
echo -e "\033[1G\033[K[ \033[32mOK\033[0m ] Download installer"

# Unzip installer into workspace
unzip -oq ${tempfile} -d ${workspace}

# Run installer
${workspace}/dotfiles-master/bin/install

# Cleanup
rm -rf ${tempfile} ${workspace}
