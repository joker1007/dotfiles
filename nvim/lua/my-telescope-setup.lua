vim.keymap.set('n', ',sff', function() require('telescope.builtin').find_files() end)
vim.keymap.set('n', ',sfr', function() require('telescope.builtin').oldfiles() end)
vim.keymap.set('n', ',sg', function() require('telescope.builtin').live_grep() end)
vim.keymap.set('n', ',sb', function() require('telescope.builtin').buffers() end)
vim.keymap.set('n', ',sh', function() require('telescope.builtin').help_tags() end)
vim.keymap.set('n', ',sz', function() require('telescope.builtin').current_buffer_fuzzy_find() end)
vim.keymap.set('n', ',sc', function() require('telescope.builtin').git_commits() end)
vim.keymap.set('n', ',sl', function() require('telescope.builtin').git_commits() end)

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
