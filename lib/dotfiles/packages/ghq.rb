module Dotfiles
  module Packages
    class Ghq < Base
      def install
        system(<<-EOS)
          brew tap motemen/ghq
          brew install ghq
        EOS
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
