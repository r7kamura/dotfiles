module Dotfiles
  module Packages
    class Ghq < Base
      def install
        system(%<ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" && brew update>)
      end

      def installed?
        system("which brew")
      end

      def uninstall
        system("brew prune && (ls -A1 $(brew --prefix) | xargs rm -rf) && rm -rf ~/Library/Caches/Homebrew ~/Library/Logs/Homebrew /Library/Caches/Homebrew")
      end
    end
  end
end
