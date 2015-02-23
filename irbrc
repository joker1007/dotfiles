require "rubygems"

begin
  require "irbtools"
rescue LoadError
end

require "irb/completion"
require "irb/ext/save-history"

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 2000
IRB.conf[:HISTORY_PATH] = File.expand_path("~/.irb-history")
