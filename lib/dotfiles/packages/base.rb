module Dotfiles
  module Packages
    class Base
      NG = "\e[31mNG\e[0m"
      OK = "\e[32mOK\e[0m"

      # @return [String]
      def name
        self.class.name.split("::").last
      end

      # @return [true, false] True if already installed and respondable to .uninstall method
      def uninstallable?
        installed? && respond_to?(:uninstall)
      end

      # @return [String]
      def installation_status
        "[ #{installed? ? OK : NG} ] #{name} should be installed"
      end

      # @return [String]
      def uninstallation_status
        "[ #{installed? ? NG : OK} ] #{name} should be uninstalled"
      end
    end
  end
end
