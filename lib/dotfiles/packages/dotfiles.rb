module Dotfiles
  module Packages
    class Dotfiles < Base
      def update
        system(<<-EOS)
          GOPATH=$HOME ghq get r7kamura/dotfiles
          GOPATH=$HOME cd $(ghq list -p r7kamura/dotfiles)
          rake install
        EOS
      end

      def installed?
        true
      end

      def uninstall
        system("rake uninstall")
      end
    end
  end
end
