module Dotfiles
  module Packages
    class Dotfiles < Base
      def update
        system({ "GOPATH" => ENV["HOME"] }, <<-EOS)
          ghq get r7kamura/dotfiles
          cd $(ghq list -p r7kamura/dotfiles)
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
