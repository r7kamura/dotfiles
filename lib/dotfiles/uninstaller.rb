module Dotfiles
  class Uninstaller < Installer
    def call
      checker.uninstallable_packages.each do |package|
        package.uninstall if package.installed
        puts package.uninstallation_message
      end
    end
  end
end
