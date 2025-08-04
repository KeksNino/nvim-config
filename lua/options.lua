require "nvchad.mappings"
require "nvchad.options"

local Snacks = require ("snacks")
--
vim.keymap.del("n", "<leader>e")
vim.keymap.set("n", "<leader>e", function() Snacks.explorer.open() end, { desc = "File Explorer" })
