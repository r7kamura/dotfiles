module Dotfiles
  module Packages
    class LoginShell < Base
      ORIGINAL_SHELL_PATH = "/bin/bash"
      CUSTOMIZED_SHELL_PATH = "/usr/local/bin/zsh"

      def install
        system(<<-EOS)
          sudo sh -c "echo #{CUSTOMIZED_SHELL_PATH} >> /etc/shells"
          chsh -s #{CUSTOMIZED_SHELL_PATH}
        EOS
      end

      def installed?
        ENV["SHELL"] == CUSTOMIZED_SHELL_PATH
      end

      def uninstall
        system(<<-EOS)
          sudo sh -c "sed -e /#{CUSTOMIZED_SHELL_PATH.gsub("/", '\\/')}/d /etc/shells
          chsh -s #{ORIGINAL_SHELL_PATH}
        EOS
      end
    end
  end
end
