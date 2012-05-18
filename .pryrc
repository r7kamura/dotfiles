begin
  require "awesome_print"
rescue
  puts "Please `gem install awesome_print`"
end

def pbcopy(str, opts = {})
  IO.popen('pbcopy', 'r+') { |io| io.print str }
end

Pry.config.commands.command "copy", "Copy last evaluated object to clipboard" do
  pbcopy _pry_.last_result.ai(:plain => true, :indent => 2, :index => false)
  output.puts "Copied!"
end
