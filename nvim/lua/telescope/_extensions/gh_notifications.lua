local actions = require "telescope.actions"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local entry_display = require "telescope.pickers.entry_display"
local action_state = require "telescope.actions.state"
local Job = require "plenary.job"

local displayer = entry_display.create({
  separator = " ",
  items = {
    { width = 2 },
    { width = 30 },
    { width = 16 },
    { remaining = true },
  },
})

local type_icon_table = {
  ["Issue"] = "  ",
  ["PullRequest"] = "  ",
}

local make_display = function(entry)
  local notification = entry.value
  local subject = notification.subject
  local unread_mark = notification.unread and "✅" or ""
  return displayer({
    unread_mark,
    "  " .. notification.repo,
    notification.reason,
    type_icon_table[subject.type] .. subject.title,
  })
end

local get_html_url = function(notification, opts)
  opts = opts or {}
  local url = ""
  if opts.latest_comment and notification.subject.latest_comment_url ~= vim.NIL then
    url = notification.subject.latest_comment_url
  else
    url = notification.subject.url
  end
  local result = ""
  Job:new({
    command = "gh",
    args = { "api", url, "--jq", ".html_url" },
    on_exit = function(j, return_val)
      if return_val == 0 then
        result = j:result()[1]
      end
    end,
  }):sync()

  return result
end

local mark_thread_as_read = function(notification)
  if notification.unread then
    Job:new({
      command = "gh",
      args = { "api", "-X", "PATCH", notification.url },
      ---@diagnostic disable-next-line: unused-local
      on_exit = function(j, return_val)
        if return_val == 0 then
          vim.notify("Mark " .. notification.subject.title .. " as read", "info", { title = "GitHub Notifications" })
        else
          vim.notify(
            "Failed to mark " .. notification.subject.title .. " as read",
            "error",
            { title = "GitHub Notifications" }
          )
        end
      end,
    }):start()
  end
end

local make_octo_opener = function(prompt_bufnr)
  return function()
    local entry = action_state.get_selected_entry()
    local html_url = get_html_url(entry.value)
    actions.close(prompt_bufnr)
    mark_thread_as_read(entry.value)
    vim.cmd("Octo " .. html_url)
  end
end

local open_by_browser = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local html_url = get_html_url(entry.value, { latest_comment = true })
  actions.close(prompt_bufnr)
  mark_thread_as_read(entry.value)
  require("urlview.actions").system(html_url)
end

local notifications_finder = finders.new_oneshot_job({
  "gh",
  "api",
  "notifications?all=true",
  "--jq",
  ".[] | {updated_at, unread, reason, subject, url, repo: .repository.name}",
}, {
  entry_maker = function(line)
    local n = vim.fn.json_decode(line)
    if n == nil then
      vim.notify("Failed to fetch notifications", "error")
      return {}
    else
      return {
        ordinal = n.updated_at .. n.subject.title .. n.repo,
        display = make_display,
        value = n,
      }
    end
  end,
})

local function search(opts)
  pickers
    .new(opts, {
      prompt_title = "GitHub Notifications",
      sorter = conf.generic_sorter(opts),
      finder = notifications_finder,
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(make_octo_opener(prompt_bufnr))
        map("n", "v", open_by_browser)
        map("i", "<C-v>", open_by_browser)
        -- needs to return true if you want to map default_mappings and
        return true
      end,
    })
    :find()
end

return require("telescope").register_extension({
  setup = function(ext_config, config) end,
  exports = { gh_notifications = search },
})
