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

  def self.install
    new.install
  end

  def self.uninstall
    new.uninstall
  end

  def initialize
    @paths = Dir::entries(".").reject { |path| ignore_regexp === path }
  end

  def install
    @paths.each { |path| put_symlink(path) }
    puts "Successfully installed!"
  end

  def uninstall
    @paths.each { |path| remove_symlink(path) }
    puts "Successfully uninstalled!"
  end

  private

  def remove_symlink(path)
    from = File.expand_path(path, "~")
    if File.symlink?(from)
      to = File.readlink(from)
      File.delete(from)
      puts "Remove symlink: #{from} -> #{to}"
    end
  rescue Errno::ENOENT
  end

  def put_symlink(path)
    from = File.expand_path(path, "~")
    to   = File.expand_path(path)
    File.symlink(to, from)
    puts "Create symlink: #{from} -> #{to}"
  rescue Errno::EEXIST => e
    puts "Already exists: #{from}"
  end

  def ignore_regexp
    @ignore_regexp ||= begin
      str = Regexp.union(*IGNORE_PATTERNS).to_s
      str.gsub!("\\*", ".*?")
      Regexp.new("^#{str}$")
    end
  end
end

desc "Create symlink of dotfiles to $HOME"
task :install do
  DotfilesInstaller.install
end

desc "Remove symlink of dotfiles from $HOME"
task :uninstall do
  DotfilesInstaller.uninstall
end

task :default => :install
