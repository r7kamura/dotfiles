module Dotfiles
  module Packages
    class Karabiner < Base
      def update
        system("sh karabiner/update.sh")
      end
    end
  end
end
