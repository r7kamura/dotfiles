module Dotfiles
  module Packages
    class Homebrew < Base
      # Homebrew tries to use ~/Library/Caches/Homebrew then /Library/Caches/Homebrew
      def install
        system(<<-EOS)
          mkdir ~/Library/Caches/Homebrew &&
          ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &&
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
