module Dotfiles
  module Packages
    class Ghq < Base
      def install
        system(<<-EOS)
          brew tap r7kamura/ghq
          brew install ghq
        EOS
      end

      def installed?
        system("which ghq")
      end

      def uninstall
        system(<<-EOS)
          brew untap r7kamura/ghq
          brew uninstall ghq
        EOS
      end
    end
  end
end
