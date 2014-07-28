module Dotfiles
  class Checker
    # @return [Array<String>]
    def installation_statuses
      packages.map(&:installation_status)
    end

    # @return [Array<Dotfiles::Packages::Base>]
    def installable_packages
      packages.select(&:installable?)
    end

    # @return [Array<Dotfiles::Packages::Base>]
    def uninstallable_packages
      packages.select(&:uninstallable?)
    end

    private

    # @return [Array<Dotfiles::Packages::Base>]
    def packages
      @packages ||= Dotfiles::Packages.packages
    end
  end
end
