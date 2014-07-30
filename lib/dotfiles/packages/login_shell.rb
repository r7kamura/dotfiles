module Dotfiles
  module Packages
    class LoginShell < Base
      PATH = "/usr/local/bin/zsh"

      def install
        system(<<-EOS)
          sudo sh -c "echo #{PATH} >> /etc/shells"
          chsh -s #{PATH}
        EOS
      end

      def installed?
        ENV["SHELL"] == PATH
      end

      def uninstall
        system(<<-EOS)
          sudo sh -c "sed -e /#{PATH.gsub("/", '\\/')}/d /etc/shells
          chsh -s /bin/bash
        EOS
      end
    end
  end
end
