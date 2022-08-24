require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "haskell",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "perl",
    "php",
    "proto",
    "rst",
    "ruby",
    "rust",
    "scala",
    "sql",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 2000,
  }
}
