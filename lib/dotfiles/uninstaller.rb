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
      puts checker.installation_statuses
    end

    def checker
      @checker ||= Checker.new
    end

    def uninstall
      checker.installed_packages.each do |package|
        package.uninstall
        puts "[ \e[32mOK\e[0m ] Uninstall #{package.name}"
      end
    end
  end
end
