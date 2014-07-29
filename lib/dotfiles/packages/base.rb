module Dotfiles
  module Packages
    class Base
      DONE = "\e[31mDONE\e[0m"
      SKIP = "\e[32mSKIP\e[0m"

      # @return [String]
      def name
        self.class.name.split("::").last
      end

      # @return [true, false] True if already installed and respondable to .uninstall method
      def uninstallable?
        installed && respond_to?(:uninstall)
      end

      # @return [String] A message used to tell the result of installation
      def installation_message
        package.installed ? skip_installation_message : done_installation_message
      end

      # @return [String] A message to tell the installation was just done
      def done_installation_message
        "[ #{DONE} ] Install #{name}"
      end

      # @return [String] A message to tell the installation was skipped
      def skip_installation_message
        "[ #{SKIP} ] Install #{name}"
      end

      # @return [true, false]
      # @note Memoized version of .installed?
      def installed
        @installed = instance_variable_defined?(:@installed) ? @installed : installed?
      end

      # @note override to change options parameter
      def system(script, options = { out: IO::NULL, err: IO::NULL })
        super
      end
    end
  end
end
