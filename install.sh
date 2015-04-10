#!/usr/bin/env bash
set -eo pipefail

tempfile=/tmp/dotfiles.zip
workspace=/tmp/dotfiles

# Download zipped installer
curl -LSfs -o ${tempfile} https://github.com/r7kamura/dotfiles/archive/master.zip

# Unzip installer into workspace
unzip -oq ${tempfile} -d ${workspace}

# Move to repository root path
pushd ${workspace}/dotfiles-master > /dev/null

# Install command-line-tools
xcode-select -p > /dev/null
if [ "$?" -ne 0 ]; then
  xcode-select --install
  while :
  do
    xcode-select -p
    if [ "$?" -eq 0 ]; then
      break
    fi
    sleep 5
  done
fi

# Install homebrew
which brew > /dev/null
if [ "$?" -ne 0 ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install serverkit and its dependencies
gem install bundler > /dev/null
bundle install > /dev/null

# Run installer
bundle exec serverkit apply recipe.yml.erb --variables=variables.yml

# Move to original path
popd > /dev/null

# Cleanup
rm -rf ${tempfile} ${workspace}
