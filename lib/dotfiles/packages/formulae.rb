module Dotfiles
  module Packages
    class Formulae < Base
      def update
        system("brew bundle")
      end

      def installed?
        true
      end

      def uninstall
        system("brew cask list | xargs brew cask uninstall")
        system("brew list | xargs brew uninstall")
      end
    end
  end
end
