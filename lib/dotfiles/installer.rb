module Dotfiles
  class Installer
    def self.call
      new.call
    end

    def call
      check
      install
    end

    private

    def check
      puts checker.installation_statuses
    end

    def checker
      @checker ||= Checker.new
    end

    def install
      checker.lacking_packages.each do |package|
        puts "Installing #{package.name}"
        package.install
      end
    end
  end
end
