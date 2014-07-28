module Dotfiles
  module Packages
    class CommandLineTools < Base
      def install
        system("xcode-select --install", out: IO::NULL, err: IO::NULL)
      end

      def installed?
        system("xcode-select -p", out: IO::NULL, err: IO::NULL)
      end

      def uninstall
        FileUtils.rmtree(`xcode-select -p`.chomp)
      end
    end
  end
end
