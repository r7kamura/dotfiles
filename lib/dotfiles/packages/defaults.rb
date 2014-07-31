module Dotfiles
  module Packages
    class Defaults < Base
      def update
        system("bash defaults/install.sh")
      end
    end
  end
end
