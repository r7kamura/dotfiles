module Dotfiles
  class Checker
    # @return [Array<Dotfiles::Packages::Base>]
    def installable_packages
      packages.select(&:installable?)
    end

    # @return [Array<Dotfiles::Packages::Base>]
    def uninstallable_packages
      packages.select(&:uninstallable?)
    end

    # @return [Array<Dotfiles::Packages::Base>]
    def updatable_packages
      packages.select(&:updatable?)
    end

    # @return [Array<Dotfiles::Packages::Base>]
    def packages
      @packages ||= Dotfiles::Packages.packages
    end
  end
end
