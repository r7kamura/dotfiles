module Dotfiles
  class Uninstaller
    def self.call
      new.call
    end

    def call
      check
      uninstall
    end

    private

    def check
      puts checker.uninstallable_packages.map(&:uninstallation_status)
    end

    def checker
      @checker ||= Checker.new
    end

    def uninstall
      checker.uninstallable_packages.each do |package|
        package.uninstall
        puts "[ \e[32mOK\e[0m ] Uninstall #{package.name}"
      end
    end
  end
end
