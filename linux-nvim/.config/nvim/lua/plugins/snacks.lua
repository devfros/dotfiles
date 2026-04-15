return {
  "folke/snacks.nvim",
  keys = {
    {
      "gp",
      function()
        Snacks.picker.lsp_definitions({ auto_confirm = false })
      end,
      desc = "Preview Definition",
    },
    {
      "<leader>zd",
      function()
        local noice = require("noice")
        noice.disable()
        local snacks = require("snacks")
        snacks.config.zen.toggles.dim = not snacks.config.zen.toggles.dim
        snacks.toggle.zen():toggle()
        snacks.toggle.zen():toggle()
        noice.enable()
      end,
      desc = "Toggle Zen Dim",
    },
  },
  opts = {
    explorer = {
      enabled = false,
    },
    zen = {
      toggles = {
        dim = false,
      },
      show = {
        statusline = true, -- can only be shown when using the global statusline
      },
      win = {
        minimal = false,
        backdrop = { transparent = false, blend = 99 },
      },
    },
    terminal = {
      win = {
        position = "float",
      },
    },
    picker = {
      layouts = {
        dropdown = {
          layout = {
            backdrop = false,
            row = 1,
            width = 0.8,
            min_width = 80,
            height = 0.8,
            border = "none",
            box = "vertical",
            { win = "preview", title = "{preview}", height = 0.6, border = true },
            {
              box = "vertical",
              border = true,
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
      },
      layout = {
        preset = "dropdown",
      },
      sources = {
        files = {
          ignored = true,
          hidden = true,
          exclude = {
            ".git",
            ".cursor",
            ".pytest_cache",
            ".venv",
            "venv",
            ".idea",
            ".ruff_cache",
            "__pycache__",
          },
        },
        explorer = {
          enabled = false,
          ignored = true,
          hidden = true,
          exclude = {
            ".git",
            ".idea",
            ".ruff_cache",
            "__pycache__",
          },
        },
      },
    },
  },
}
