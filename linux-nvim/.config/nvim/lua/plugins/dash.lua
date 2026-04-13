local headers = {
  vibecoding = [[
██╗   ██╗██╗██████╗ ███████╗     ██████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗ 
██║   ██║██║██╔══██╗██╔════╝    ██╔════╝██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝ 
██║   ██║██║██████╔╝█████╗      ██║     ██║   ██║██║  ██║██║██╔██╗ ██║██║  ███╗
╚██╗ ██╔╝██║██╔══██╗██╔══╝      ██║     ██║   ██║██║  ██║██║██║╚██╗██║██║   ██║
 ╚████╔╝ ██║██████╔╝███████╗    ╚██████╗╚██████╔╝██████╔╝██║██║ ╚████║╚██████╔╝
  ╚═══╝  ╚═╝╚═════╝ ╚══════╝     ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ 
  ]],
  handcoding = [[
██╗  ██╗ █████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗ 
██║  ██║██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝ 
███████║███████║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██║  ██║██║██╔██╗ ██║██║  ███╗
██╔══██║██╔══██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║  ██║██║██║╚██╗██║██║   ██║
██║  ██║██║  ██║██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝██████╔╝██║██║ ╚████║╚██████╔╝
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ 
  ]],
  devfros = [[
██████╗ ███████╗██╗   ██╗███████╗██████╗  ██████╗ ███████╗
██╔══██╗██╔════╝██║   ██║██╔════╝██╔══██╗██╔═══██╗██╔════╝
██║  ██║█████╗  ██║   ██║█████╗  ██████╔╝██║   ██║███████╗
██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██╔══██╗██║   ██║╚════██║
██████╔╝███████╗ ╚████╔╝ ██║     ██║  ██║╚██████╔╝███████║
╚═════╝ ╚══════╝  ╚═══╝  ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝
  ]],
  neovim = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
  ]],
}

local header_order = { "neovim", "devfros", "vibecoding", "handcoding" }

vim.g.dashboard_header_idx = vim.g.dashboard_header_idx or 1

local function selected_header()
  local key = header_order[vim.g.dashboard_header_idx] or header_order[1]
  return headers[key] or headers.vibecoding
end

local function cycle_dashboard_header()
  vim.g.dashboard_header_idx = (vim.g.dashboard_header_idx % #header_order) + 1
  local key = header_order[vim.g.dashboard_header_idx]
  local snacks = require("snacks")

  snacks.config.dashboard = snacks.config.dashboard or {}
  snacks.config.dashboard.preset = snacks.config.dashboard.preset or {}
  snacks.config.dashboard.preset.header = headers[key] or headers.vibecoding

  if vim.bo.filetype == "snacks_dashboard" then
    snacks.dashboard.open()
    return
  end

  vim.notify("Dashboard header: " .. key)
end

return {
  "snacks.nvim",
  init = function()
    vim.api.nvim_create_user_command("DashboardHeaderCycle", cycle_dashboard_header, {
      desc = "Cycle dashboard ASCII header",
    })
  end,
  keys = {
    { "<leader>dh", cycle_dashboard_header, desc = "Cycle Dashboard Header" },
  },
  opts = {
    dashboard = {
      preset = {
        header = selected_header(),
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
