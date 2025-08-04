vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

vim.wo.number = true
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim configuration
local lazy_config = require("configs.lazy")

-- Load plugins
require("lazy").setup({
  -- NvChad plugins
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  -- Import additional plugins if any
  { import = "plugins" },
})

local lspconfig = require('lspconfig')
local cmp = require'cmp'

-- cmp autocomplete
cmp.setup({
  sources = {
      { name = 'nvim_lsp' },
  },
  mapping = {
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
})

-- Load theme and statusline
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Load options and autocommands
require("options")
require("nvchad.autocmds")

-- Schedule mappings to load asynchronously
vim.schedule(function()
  require("mappings")
end)

require('configs.lspconfig')
require('configs.neoscroll')
