module Dotfiles
  class Checker
    # @return [Array<Dotfiles::Packages::Base>]
    def uninstallable_packages
      packages.select(&:uninstallable?)
    end

    # @return [Array<Dotfiles::Packages::Base>]
    def packages
      @packages ||= Dotfiles::Packages.packages
    end
  end
end
