alias :r :require

def r(name)
  require name.to_s
end

def rr
  require "active_support/all"
end

begin
  require "awesome_print"

  def pbcopy(str, opts = {})
    IO.popen('pbcopy', 'r+') { |io| io.print str }
  end

  Pry.config.commands.command "copy", "Copy last evaluated object to clipboard" do
    pbcopy _pry_.last_result.ai(:plain => true, :indent => 2, :index => false)
    output.puts "Copied!"
  end
rescue Exception
end
