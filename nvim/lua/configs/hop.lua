local hop = require "hop"
local hint = require "hop.hint"
local wk = require "which-key"

wk.register({
  ["<leader><leader>"] = {
    f = {
      function()
        hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true })
      end,
      "Hint char (forward)",
    },
    F = {
      function()
        hop.hint_char1({ direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = true })
      end,
      "Hint char (backward)",
    },
    t = {
      function()
        hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end,
      "Hint char (forward)",
    },
    T = {
      function()
        hop.hint_char1({
          direction = hint.HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end,
      "Hint char (backward)",
    },
    w = {
      function()
        hop.hint_words({ direction = hint.HintDirection.AFTER_CURSOR })
      end,
      "Hint words (forward)",
    },
    W = {
      function()
        hop.hint_words({ direction = hint.HintDirection.BEFORE_CURSOR })
      end,
      "Hint words (backward)",
    },
    ["/"] = {
      function()
        hop.hint_patterns({ direction = hint.HintDirection.AFTER_CURSOR })
      end,
      "Hint patterns (forward)",
    },
    ["?"] = {
      function()
        hop.hint_patterns({ direction = hint.HintDirection.BEFORE_CURSOR })
      end,
      "Hint patterns (forward)",
    },
  },
})
wk.register({
  ["<leader><leader>"] = {
    f = {
      function()
        hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true })
      end,
      "Hint char (forward)",
    },
    F = {
      function()
        hop.hint_char1({ direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = true })
      end,
      "Hint char (backward)",
    },
    t = {
      function()
        hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end,
      "Hint char (forward)",
    },
    T = {
      function()
        hop.hint_char1({
          direction = hint.HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end,
      "Hint char (backward)",
    },
    w = {
      function()
        hop.hint_words({ direction = hint.HintDirection.AFTER_CURSOR })
      end,
      "Hint words (forward)",
    },
    W = {
      function()
        hop.hint_words({ direction = hint.HintDirection.BEFORE_CURSOR })
      end,
      "Hint words (backward)",
    },
    ["/"] = {
      function()
        hop.hint_patterns({ direction = hint.HintDirection.AFTER_CURSOR })
      end,
      "Hint patterns (forward)",
    },
    ["?"] = {
      function()
        hop.hint_patterns({ direction = hint.HintDirection.BEFORE_CURSOR })
      end,
      "Hint patterns (forward)",
    },
  },
}, { mode = "v" })

hop.setup({})
