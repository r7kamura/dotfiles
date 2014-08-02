module Dotfiles
  module Packages
    class Defaults < Base
      def update
        system(<<-EOS)
          cd ~/src/github.com/r7kamura/dotfiles
          git pull
          bash defaults/update.sh
        EOS
      end
    end
  end
end
