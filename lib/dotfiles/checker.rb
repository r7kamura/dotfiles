module Dotfiles
  class Checker
    # @return [Array<String>]
    def installation_statuses
      packages.map(&:installation_status)
    end

    # @return [Array<Dotfiles::Packages::Base>]
    def lacking_packages
      packages.reject(&:installed_with_memoize?)
    end

    private

    # @return [Array<Dotfiles::Packages::Base>]
    def packages
      @packages ||= Dotfiles::Packages.packages
    end
  end
end
