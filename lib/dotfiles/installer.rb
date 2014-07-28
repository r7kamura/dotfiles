module Dotfiles
  class Installer
    DONE = "\e[31mDONE\e[0m"
    SKIP = "\e[32mSKIP\e[0m"

    def self.call
      new.call
    end

    def call
      checker.packages.each do |package|
        package.install unless package.installed?
        puts "[ #{package.installed? ? SKIP : DONE} ] Install #{package.name}"
      end
    end

    private

    def checker
      @checker ||= Checker.new
    end
  end
end
