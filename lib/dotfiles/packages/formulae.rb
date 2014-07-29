module Dotfiles
  module Packages
    class Formulae < Base
      def update
        system("brew bundle")
      end
    end
  end
end
