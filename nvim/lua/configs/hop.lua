local hop = require "hop"
local hint = require "hop.hint"
local wk = require "which-key"

wk.add({
  {
    "<leader><leader>f",
    function()
      hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true })
    end,
    desc = "Hint char (forward)",
  },
  {
    "<leader><leader>F",
    function()
      hop.hint_char1({ direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = true })
    end,
    desc = "Hint char (backward)",
  },
  {
    "<leader><leader>t",
    function()
      hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end,
    desc = "Hint char (forward)",
  },
  {
    "<leader><leader>T",
    function()
      hop.hint_char1({
        direction = hint.HintDirection.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = -1,
      })
    end,
    desc = "Hint char (backward)",
  },
  {
    "<leader><leader>w",
    function()
      hop.hint_words({ direction = hint.HintDirection.AFTER_CURSOR })
    end,
    desc = "Hint words (forward)",
  },
  {
    "<leader><leader>W",
    function()
      hop.hint_words({ direction = hint.HintDirection.BEFORE_CURSOR })
    end,
    desc = "Hint words (backward)",
  },
  {
    "<leader><leader>/",
    function()
      hop.hint_patterns({ direction = hint.HintDirection.AFTER_CURSOR })
    end,
    desc = "Hint patterns (forward)",
  },
  {
    "<leader><leader>?",
    function()
      hop.hint_patterns({ direction = hint.HintDirection.BEFORE_CURSOR })
    end,
    desc = "Hint patterns (forward)",
  },
})

hop.setup({})
