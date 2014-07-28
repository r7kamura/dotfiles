module Dotfiles
  module Packages
    class Homebrew < Base
      def install
        system(%<ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)">)
        system("brew update")
      end

      def installed?
        system("which brew", out: IO::NULL, err: IO::NULL)
      end

      def uninstall
        system("brew prune")
        system("ls -A1 $(brew --prefix) | xargs rm -rf")
        system("rm -rf ~/Library/Caches/Homebrew ~/Library/Logs/Homebrew /Library/Caches/Homebrew")
      end
    end
  end
end
