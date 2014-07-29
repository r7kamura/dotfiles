module Dotfiles
  class Installer
    def self.call
      new.call
    end

    # For each package, install if not installed then print out message
    def call
      checker.packages.each do |package|
        package.install if package.installed
        puts package.installation_message
      end
    end

    private

    def checker
      @checker ||= Checker.new
    end
  end
end
