IRB.conf[:SAVE_HISTORY] = 2000
IRB.conf[:COMPLETOR] = :type

Reline::Face.config(:completion_dialog) do |conf|
  conf.define :default, foreground: :white, background: :bright_black
  conf.define :enhanced, foreground: "#232136", background: "#a3be8c", style: :bold
end
