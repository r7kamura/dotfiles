module Dotfiles
  module Packages
    class Homebrew < Base
      def install
        system(%<ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)">)
      end

      def installed?
        system("which brew", out: IO::NULL, err: IO::NULL)
      end

      def uninstall
        system("curl -LSfs https://gist.githubusercontent.com/mxcl/1173223/raw/a833ba44e7be8428d877e58640720ff43c59dbad/uninstall_homebrew.sh | bash -s")
      end
    end
  end
end
