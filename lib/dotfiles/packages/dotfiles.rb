module Dotfiles
  module Packages
    class Dotfiles < Base
      PATH = File.expand_path("~/src/github.com/r7kamura/dotfiles")

      def update
        (Dir.entries("linked") - [".DS_Store", ".", ".."]).each do |filename|
          destination = File.expand_path("linked/#{filename}")
          destination = destination + "/" if File.directory?(destination)
          source = File.expand_path("~/#{filename}")
          File.symlink(destination, source) rescue nil
        end
      end

      def installed?
        Dir.exist?(PATH)
      end

      def install
        system("git clone https://github.com/r7kamura/dotfiles.git #{PATH}")
      end

      def uninstall
        system(<<-EOS)
          cd #{PATH}/linked
          ls -A | xargs -I% rm ~/%
          rm -rf #{PATH}
        EOS
      end
    end
  end
end
