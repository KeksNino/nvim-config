require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
vim.opt.mouse = ""

map("i", "jk", "<ESC>")
vim.keymap.set('n', '<S-e>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Unmap <C-N> from normal mode
vim.api.nvim_del_keymap('n', '<C-n>')

-- Reassign it to Visual Multi for subword under feature
vim.g.VM_maps = vim.g.VM_maps or {}
vim.g.VM_maps['<C-n>'] = '<Plug>(VM-Find-Subword-Under)'
vim.g.mapleader = " "
vim.keymap.set("i", "<C-l>", function()
  require("copilot.suggestion").accept()
end, { noremap = true, silent = true })

vim.api.nvim_set_keymap('', '<ScrollWheelUp>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<ScrollWheelDown>', '<Nop>', { noremap = true, silent = true })

vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { noremap = true, silent = true }) -- Next tab
vim.keymap.set('n', '<S-Tab>', ':tabprev<CR>', { noremap = true, silent = true }) -- Previous tab
vim.keymap.set('n', 'tn', ':tabnew<CR>', { noremap = true, silent = true }) -- New tab
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true }) -- Close tab

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
