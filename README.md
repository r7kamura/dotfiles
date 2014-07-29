## Install
After opening your brand-new macbook, open Terminal.app and copy-paste the following command.
After a few minutes, all of these packages will be installed.
If there are already installed packages, their installation steps will be skipped.
Note: The installing/uninstalling Homebrew step requires sudo permission,
so you may need to type your password following to the prompt message.

* CommandLineTools
* Homebrew
* Ghq

```sh
curl -LSfs https://raw.githubusercontent.com/r7kamura/dotfiles/master/install.sh | bash
```

## Uninstall
The following packages will be uninstalled.
Note: You need sudo permission to remove Homebrew's cache files from system directory.

* Homebrew
* Ghq

```sh
curl -LSfs https://raw.githubusercontent.com/r7kamura/dotfiles/master/uninstall.sh | sudo bash
```
