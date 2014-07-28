require "fileutils"

module Dotfiles
  module Packages
    class CommandLineTools < Base
      def install
        system("xcode-select --install", out: IO::NULL, err: IO::NULL)
        sleep 5 until installed?
      end

      def installed?
        system("xcode-select -p", out: IO::NULL, err: IO::NULL)
      end
    end
  end
end
