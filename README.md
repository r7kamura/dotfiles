## Install
After opening your brand-new macbook, open Terminal.app and copy-paste the following command.
If there are already installed packages, their installation steps will be skipped.

### Installed pacakges
* CommandLineTools
* Homebrew
* Ghq

```sh
curl -LSfs https://raw.githubusercontent.com/r7kamura/dotfiles/master/install.sh | bash
```

## Uninstall
The following packages will be uninstalled.
Note: You need sudo permission to remove Homebrew's cache files from system directory.

### Uninstalled pacakges
Note: CommandLineTools won't be uninstalled.

* Homebrew
* Ghq

```sh
curl -LSfs https://raw.githubusercontent.com/r7kamura/dotfiles/master/uninstall.sh | sudo bash
```
