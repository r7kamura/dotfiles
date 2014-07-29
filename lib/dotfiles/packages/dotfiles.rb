module Dotfiles
  module Packages
    class Dotfiles < Base
      def update
        system("rake install")
      end

      def uninstall
        system("rake uninstall")
      end
    end
  end
end
