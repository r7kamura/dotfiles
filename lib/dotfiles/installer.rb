module Dotfiles
  class Installer
    def self.call
      new.call
    end

    def call
      install
      update
    end

    private

    def checker
      @checker ||= Checker.new
    end

    def install
      checker.installable_packages.each do |package|
        package.install unless package.installed
        puts package.installation_message
      end
    end

    def update
      checker.updatable_packages.each do |package|
        package.update
        puts package.update_message
      end
    end
  end
end
