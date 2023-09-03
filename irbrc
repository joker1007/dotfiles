require "irb/ext/save-history"

IRB.conf[:SAVE_HISTORY] = 2000
IRB.conf[:HISTORY_PATH] = File.expand_path("~/.irb-history")

require 'katakata_irb' rescue nil
