require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "make",
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
    disable = { "markdown" },
  },
  incremental_selection = {
    enable = true,
    disable = { "markdown" },
  },
  indent = {
    enable = true,
    disable = { "markdown" },
  },
  matchup = {
    enable = true,
    disable = { "markdown" },
  },
}
