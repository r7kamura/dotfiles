module Dotfiles
  module Packages
    class Dotfiles < Base
      PATH = File.expand_path("~/src/github.com/r7kamura/dotfiles")

      def update
        system(<<-EOS)
          cd #{PATH}/linked &&
          ls -FA | grep -v .DS_Store | xargs -I% ln -s $(PWD)/% ~/%
        EOS
      end

      def installed?
        Dir.exist?(PATH)
      end

      def install
        system("git clone https://github.com/r7kamura/dotfiles.git #{PATH}")
      end

      def uninstall
        system(<<-EOS)
          pushd #{PATH}/linked
          ls -A | xargs -I% rm ~/%
          popd
          rm -rf #{PATH}
        EOS
      end
    end
  end
end
