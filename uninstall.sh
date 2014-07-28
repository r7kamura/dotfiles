#!/usr/bin/env bash
set -eo pipefail

tempfile=/tmp/dotfiles.zip
workspace=/tmp/dotfiles

# Download zipped uninstaller
curl -LSfs -o ${tempfile} https://github.com/r7kamura/dotfiles/archive/master.zip
echo -e "[ \033[32mOK\033[0m ] Download Uninstaller"

# Unzip uninstaller into workspace
unzip -oq ${tempfile} -d ${workspace}

# Run uninstaller
${workspace}/dotfiles-master/bin/uninstall

# Cleanup
rm -rf ${tempfile} ${workspace}
