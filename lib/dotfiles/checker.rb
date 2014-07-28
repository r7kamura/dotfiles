module Dotfiles
  class Checker
    # @return [Array<Dotfiles::Packages::Base>]
    def uninstallable_packages
      packages.select(&:uninstallable?)
    end

    def not_installed_packages
      packages.reject(&:installed?)
    end

    # @return [Array<Dotfiles::Packages::Base>]
    def packages
      @packages ||= Dotfiles::Packages.packages
    end
  end
end
