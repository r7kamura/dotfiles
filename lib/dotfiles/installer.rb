module Dotfiles
  class Installer
    DONE = "\e[31mDONE\e[0m"
    SKIP = "\e[32mSKIP\e[0m"

    def self.call
      new.call
    end

    def call
      checker.packages.each do |package|
        if package.installed?
          puts "[ #{SKIP} ] #{message}"
        else
          package.install
          puts "[ #{DONE} ] #{message}"
        end
      end
    end

    private

    def checker
      @checker ||= Checker.new
    end

    def message
      "Install #{package.name}"
    end
  end
end
