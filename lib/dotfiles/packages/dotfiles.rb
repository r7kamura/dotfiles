require "fileutils"

module Dotfiles
  module Packages
    class Dotfiles < Base
      PATH = File.expand_path("~/src/github.com/r7kamura/dotfiles")

      SYMLINK_TABLE = {
        "~/.atom" => "linked/.atom/",
        "~/.gemrc" => "linked/.gemrc",
        "~/.gitconfig" => "linked/.gitconfig",
        "~/.gitexcludes" => "linked/.gitexcludes",
        "~/.gitignore" => "linked/.gitignore",
        "~/.gvimrc" => "linked/.gvimrc",
        "~/.inputrc" => "linked/.inputrc",
        "~/.pryrc" => "linked/.pryrc",
        "~/.rbenv/default-gems" => "linked/.rbenv/default-gems",
        "~/.rspec" => "linked/.rspec",
        "~/.tigrc" => "linked/.tigrc",
        "~/.tmux.conf" => "linked/.tmux.conf",
        "~/.vim" => "linked/.vim/",
        "~/.vimrc" => "linked/.vimrc",
        "~/.zsh" => "linked/.zsh/",
        "~/.zshrc" => "linked/.zshrc",
      }.inject({}) do |result, (key, value)|
        result.merge(
          File.expand_path(key) => File.expand_path(value)
        )
      end

      def update
        system("cd #{PATH} && git pull")
        SYMLINK_TABLE.each do |destination, source|
          File.symlink(source, destination) rescue nil
        end
      end

      def installed?
        Dir.exist?(PATH)
      end

      def install
        system("git clone https://github.com/r7kamura/dotfiles.git #{PATH}")
      end

      def uninstall
        FileUtils.rm(SYMLINK_TABLE.keys)
      end
    end
  end
end
