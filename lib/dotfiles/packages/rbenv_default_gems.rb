module Dotfiles
  module Packages
    class RbenvDefaultGems < Base
      PATH = File.expand_path("~/.rbenv/plugins/rbenv-default-gems")

      def install
        system(<<-EOS)
          git clone https://github.com/sstephenson/rbenv-default-gems.git #{PATH}
        EOS
      end

      def installed?
        Dir.exist?(PATH)
      end
    end
  end
end
