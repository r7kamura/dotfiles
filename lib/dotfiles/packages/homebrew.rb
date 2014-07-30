module Dotfiles
  module Packages
    class Homebrew < Base
      # Homebrew tries to use ~/Library/Caches/Homebrew then /Library/Caches/Homebrew
      def install
        system(<<-EOS)
          ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" &&
          mkdir ~/Library/Caches/Homebrew
          brew update
        EOS
      end

      def installed?
        system("which brew")
      end

      def uninstall
        system(<<-EOS)
          brew prune &&
          (ls -A1 $(brew --prefix) | xargs rm -rf) &&
          rm -rf ~/Library/Caches/Homebrew ~/Library/Logs/Homebrew
        EOS
      end
    end
  end
end
