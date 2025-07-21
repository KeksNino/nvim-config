require "nvchad.options"

local Snacks = require ("snacks")

Snacks.setup({
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  explorer = { enabled = true},
  -- indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  -- scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  keys = {
        { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    }
  })

