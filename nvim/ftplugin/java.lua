local util = require "lspconfig.util"
local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()
local bin = util.path.join(jdtls_path, "bin", "jdtls")

local cache_dir = vim.env.XDG_CACHE_HOME or util.path.join(vim.env.HOME, ".cache")
local jdtls_cache_dir = util.path.join(cache_dir, "jdtls")
local jdtls_config_dir = util.path.join(jdtls_cache_dir, "config")
local jdtls_workspace_dir = util.path.join(jdtls_cache_dir, "workspace")

local lombok_path = util.path.join(vim.fn.stdpath("config"), "dependencies", "lombok.jar")

local lsp_common = require("lsp_common")
local on_attach = lsp_common.on_attach

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    bin,
    "-configuration",
    jdtls_config_dir,
    "-data",
    jdtls_workspace_dir,

    "--jvm-arg=-javaagent:" .. lombok_path,
    "--jvm-arg=-Xbootclasspath/a:" .. lombok_path,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {},
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },

  on_attach = on_attach,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
