module Dotfiles
  module Packages
    class Homebrew < Base
      def install
        system(%<ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" && brew update>, out: IO::NULL, err: IO::NULL)
      end

      def installed?
        system("which brew", out: IO::NULL, err: IO::NULL)
      end

      def uninstall
        system("brew prune && (ls -A1 $(brew --prefix) | xargs rm -rf) && rm -rf ~/Library/Caches/Homebrew ~/Library/Logs/Homebrew", out: IO::NULL, err: IO::NULL)
      end
    end
  end
end
