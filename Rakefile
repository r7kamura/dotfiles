#!/usr/bin/env rake

class DotfilesInstaller
  IGNORE_PATTERNS = %w[
    .
    ..
    .git
    .gitignore
    .DS_Store
    *.swp
    Rakefile
  ]

  def self.run
    new.install
  end

  def initialize
    @paths = Dir::entries(".").reject { |path| ignore_regexp === path }
  end

  def install
    @paths.each { |path| put_symlink(path) }
  end

  private

  def put_symlink(path)
    new = File.expand_path(path, "~")
    old = File.expand_path(path)
    File.symlink(old, new)
    puts "Create symlink: #{new} -> #{old}"
  rescue Errno::EEXIST => e
    puts "Already exists: #{new}"
  end

  def ignore_regexp
    @ignore_regexp ||= begin
      str = Regexp.union(*IGNORE_PATTERNS).to_s
      str.gsub!("\\*", ".*?")
      Regexp.new("^#{str}$")
    end
  end
end

desc "Symlink dotfiles to $HOME"
task :install do
  DotfilesInstaller.run
end

task :default => :install
