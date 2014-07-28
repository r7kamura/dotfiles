module Dotfiles
  module Packages
    class Base
      # @return [String] Human readable installation status
      def installation_status
        "[ #{ok_or_ng} ] Check #{name}"
      end

      # @return [String]
      def name
        self.class.name.split("::").last
      end

      # @return [true, false] True if not yet installed
      def installable?
        @installable = instance_variable_defined?(:@installable) ? @installable : installed?
      end

      # @return [true, false] True if already installed and respondable to .uninstall method
      def uninstallable?
        !installable? && respond_to?(:uninstall)
      end

      private

      # @return [String]
      def ok_or_ng
        installed_with_memoize? ? green("OK") : red("NG")
      end

      # @return [String]
      def green(str)
        "\e[32m#{str}\e[0m"
      end

      # @return [String]
      def red(str)
        "\e[31m#{str}\e[0m"
      end
    end
  end
end
