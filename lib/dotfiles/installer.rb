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
      puts checker.packages.map(&:installation_status)
    end

    def checker
      @checker ||= Checker.new
    end

    def install
      checker.installable_packages.each do |package|
        package.install
        puts "[ \e[32mOK\e[0m ] Install #{package.name}"
      end
    end
  end
end
