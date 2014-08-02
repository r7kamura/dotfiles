module Dotfiles
  module Packages
    class Defaults < Base
      def update
        system("bash defaults/update.sh")
      end
    end
  end
end
