module Dotfiles
  module Packages
    class << self
      # @return [Array<Dotfiles::Packages::Base>]
      def packages
        package_classes.map {|klass| klass.new }
      end

      private

      # @return [Array<Symbol>]
      def package_names
        Dotfiles::Packages.constants - [:Base]
      end

      # @return [Array<Class>]
      def package_classes
        package_names.map {|name| const_get(name) }
      end
    end
  end
end
