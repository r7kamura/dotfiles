#!/usr/bin/env bash
set -eo pipefail

# Download zipped installer
echo -n "Downloading installer..."
curl -LSfs -o /tmp/dotfiles.zip https://github.com/r7kamura/dotfiles/archive/master.zip
echo "Done"

# Unzip installer into /tmp/dotfiles/dotfiles-master
unzip -q /tmp/dotfiles.zip -d /tmp/dotfiles

# Run installer
/tmp/dotfiles/dotfiles-master/bin/install

# Cleanup
rm -rf /tmp/dotfiles /tmp/dotfiles.zip
