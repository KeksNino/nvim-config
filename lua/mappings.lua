require "nvchad.mappings"

local map = vim.keymap.set

map("i", "jk", "<ESC>")
vim.api.nvim_del_keymap('n', '<C-n>')

vim.g.VM_maps = vim.g.VM_maps or {}
vim.g.VM_maps['<C-n>'] = '<Plug>(VM-Find-Subword-Under)'
vim.g.mapleader = " "
vim.keymap.set("n", "<C-o>", ':CopilotChatOpen<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>t", function()
  local word = vim.fn.expand("<cword>")
  if word == "true" then
    vim.cmd("normal! ciwfalse")
  elseif word == "false" then
    vim.cmd("normal! ciwtrue")
  end
end, { noremap = true, silent = true })

-- vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<S-Tab>', ':tabprev<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', 'tn', ':tabnew<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })

-- Make d, dd, x, etc. not copy to register
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set("v", "d", '"_d', { noremap = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>rg", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
