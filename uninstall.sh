#!/usr/bin/env bash
set -eo pipefail

tempfile=/tmp/dotfiles.zip
workspace=/tmp/dotfiles

# Download zipped uninstaller
curl -LSfs -o ${tempfile} https://github.com/r7kamura/dotfiles/archive/master.zip

# Unzip uninstaller into workspace
unzip -oq ${tempfile} -d ${workspace}

# Run uninstaller
${workspace}/dotfiles-master/bin/uninstall

# Cleanup
rm -rf ${tempfile} ${workspace}
