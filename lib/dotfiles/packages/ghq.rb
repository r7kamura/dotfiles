module Dotfiles
  module Packages
    class Ghq < Base
      def install
        system("brew install ghq")
      end

      def installed?
        system("which ghq")
      end

      def uninstall
        system("brew uninstall ghq")
      end
    end
  end
end