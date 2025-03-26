require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "html", "cssls" },  -- Ensure pyright is installed
})

-- Load lspconfig
local lspconfig = require("lspconfig")
local nvlsp = require "nvchad.configs.lspconfig"

-- Set up servers
local servers = { "html", "cssls", "pyright" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
end

lspconfig.pyright.setup({
  on_attach = function(client, bufnr)
    -- You can add custom on_attach behavior here, such as keymaps or other actions.
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(), -- If you're using nvim-cmp
})

-- Install necessary tools using mason-tool-installer
require('mason-tool-installer').setup({
  ensure_installed = {
    'black',
    'debugpy',
    'flake8',
    'isort',
    'mypy',
    'pylint',
  },
})

