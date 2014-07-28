module Dotfiles
  class Uninstaller < Installer
    def call
      checker.uninstallable_packages.each do |package|
        if package.installed?
          package.uninstall
          puts "[ #{DONE} ] Uninstall #{package.name}"
        else
          puts "[ #{SKIP} ] Uninstall #{package.name}"
        end
      end
    end
  end
end
