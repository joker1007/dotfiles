local actions = require "telescope.actions"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local action_state = require "telescope.actions.state"

local members_finder = function(owner, repo)
  owner = owner or "{owner}"
  repo = repo or "{repo}"
  local url = "/repos/" .. owner .. "/" .. repo .. "/collaborators"
  return finders.new_oneshot_job({
    "gh",
    "api",
    url,
    "--paginate",
    "--cache",
    "1h",
    "--jq",
    ".[].login",
  }, {})
end

local function search(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "GitHub Collaborators",
      sorter = conf.generic_sorter(opts),
      finder = members_finder(opts.owner, opts.repo),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          local member = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.fn.setreg("*", member)
          vim.fn.setreg("+", member)
        end)
        -- needs to return true if you want to map default_mappings and
        return true
      end,
    })
    :find()
end

return require("telescope").register_extension({
  setup = function(ext_config, config) end,
  exports = { gh_collaborators = search },
})
