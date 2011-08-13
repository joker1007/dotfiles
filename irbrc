require "rubygems"

begin
  require "interactive_editor"
rescue LoadError => err
  warn "Couldn't load interactive_editor: #{err}"
end

begin
  # load wirble
  require 'wirble'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

require "irb/completion"
require "irb/ext/save-history"

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 2000
IRB.conf[:HISTORY_PATH] = File.expand_path("~/.irb-history")
