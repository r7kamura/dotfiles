module Dotfiles
  module Packages
    class Formulae < Base
      def update
        system("brew bundle")
      end

      def uninstall
        system("brew list | xargs brew uninstall")
      end
    end
  end
end
