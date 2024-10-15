local skkeleton_mode_table = {
  ["hira"] = "あ",
  ["kata"] = "ア",
  ["hankata"] = "ｱ",
  ["zenkaku"] = "Ａ",
}
local function skkeleton_mode()
  local mode = vim.fn['skkeleton#mode']()
  if mode == "" then
    return "SKK: disabled"
  else
    local indicator = skkeleton_mode_table[mode]
    if indicator == nil then
      indicator = mode
    end
    return "SKK: " .. indicator
  end
end

require("lualine").setup({
  sections = {
    lualine_a = { "mode", skkeleton_mode },
    lualine_b = {
      "branch",
      { "diff", colored = true, diff_color = { added = "DiffAdd", modified = "DiffChange", removed = "DiffDelete" } },
      {
        "diagnostics",
        sources = { "nvim_lsp", "nvim_diagnostic", "ale" },
        colored = true,
        diagnostics_color = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
        },
        symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
      },
    },
    lualine_c = { { "filename", path = 1, shorting_target = 60 } },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  extensions = { "quickfix", "nvim-tree", "fugitive" },
})
