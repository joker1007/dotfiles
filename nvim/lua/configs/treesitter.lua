local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.hypr = {
  install_info = {
    url = "https://github.com/luckasRanarison/tree-sitter-hypr",
    files = { "src/parser.c" },
    branch = "master",
  },
  filetype = "hypr",
}
parser_config.rbs = {
  install_info = {
    url = "https://github.com/joker1007/tree-sitter-rbs",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "rbs",
}

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "diff",
    "dockerfile",
    "embedded_template",
    "haskell",
    "html",
    "java",
    "javascript",
    "json",
    "git_config",
    "gitcommit",
    "go",
    "graphql",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "perl",
    "php",
    "proto",
    "query",
    "regex",
    "rbs",
    "rst",
    "ruby",
    "rust",
    "scala",
    "sql",
    "tsx",
    "toml",
    "typescript",
    "vim",
    "yaml",
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
  matchup = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 2000,
  },
  endwise = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@function.outer"] = "V", -- linewise
        ["@class.outer"] = "<c-v>", -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = false,
    },
  },
})
