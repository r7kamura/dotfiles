module Dotfiles
  module Packages
    class LoginShell < Base
      PATH = "/usr/local/bin/zsh"

      def update
        unless updated?
          system(<<-EOS)
            sudo sh -c "echo #{PATH} >> /etc/shells"
            chsh -s #{PATH}
          EOS
        end
      end

      def uninstall
        system(<<-EOS)
          sudo sh -c "sed -e /#{PATH.gsub("/", '\\/')}/d /etc/shells
          chsh -s /bin/bash
        EOS
      end

      private

      def updated?
        ENV["SHELL"] == PATH
      end
    end
  end
end
