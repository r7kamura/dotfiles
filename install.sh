#!/usr/bin/env bash
set -eo pipefail

tempfile=/tmp/dotfiles.zip
workspace=/tmp/dotfiles

# Download zipped installer
echo -n "Downloading installer..."
curl -LSfs -o ${tempfile} https://github.com/r7kamura/dotfiles/archive/master.zip
echo "Done"

# Unzip installer into workspace
unzip -oq ${tempfile} -d ${workspace}

# Run installer
${workspace}/dotfiles-master/bin/install

# Cleanup
rm -rf ${tempfile} ${workspace}
