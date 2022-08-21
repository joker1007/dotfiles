require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      {'diff', colored = true, diff_color = {added = 'DiffAdd', modified = 'DiffChange', removed = 'DiffDelete'}},
      {'diagnostics', sources = {'ale'}, colored = true, diagnostics_color = {error = 'DiagnosticError', warn = 'DiagnosticWarn', info = 'DiagnosticInfo', hint = 'DiagnosticHint'}, symbols = {error = 'E:', warn = 'W:', info = 'I:', hint = 'H:'}}},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  extensions = {'quickfix', 'nvim-tree', 'fugitive'}
}
