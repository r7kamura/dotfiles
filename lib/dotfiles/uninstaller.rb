module Dotfiles
  class Uninstaller < Installer
    def call
      checker.uninstallable_packages.each do |package|
        package.uninstall if package.installed?
        puts "[ #{package.installed? ? DONE : SKIP} ] Uninstall #{package.name}"
      end
    end
  end
end
