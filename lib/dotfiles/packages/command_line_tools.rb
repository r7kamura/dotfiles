require "fileutils"

module Dotfiles
  module Packages
    class CommandLineTools < Base
      def install
        prompt
        sleep 5 until installed?
      end

      def installed?
        system("xcode-select -p")
      end

      private

      # Prompt user to install CommandLineTools via GUI
      def prompt
        system("xcode-select --install")
      end
    end
  end
end
