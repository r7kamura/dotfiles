module Dotfiles
  class Installer
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
        puts "Uninstalling #{package.name}"
        package.uninstall
      end
    end
  end
end
