module Dotfiles
  class Uninstaller < Installer
    def call
      checker.uninstallable_packages.each do |package|
        if package.installed?
          package.uninstall
          puts "[ #{DONE} ] #{message}"
        else
          puts "[ #{SKIP} ] #{message}"
        end
      end
    end

    private

    def message
      "Uninstall #{package.name}"
    end
  end
end
