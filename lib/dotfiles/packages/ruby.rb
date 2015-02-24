module Dotfiles
  module Packages
    class Ruby < Base
      VERSION = "2.2.0"

      def install
        system(<<-EOS)
          RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline) \
            --with-openssl-dir=$(brew --prefix openssl)" rbenv install #{VERSION}
          rbenv global #{VERSION}
        EOS
      end

      def installed?
        `rbenv versions`.include?(VERSION)
      end

      def uninstall
        system(<<-EOS)
          rbenv uninstall #{VERSION}
          rbenv global system
        EOS
      end
    end
  end
end
