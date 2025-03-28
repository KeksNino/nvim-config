return {
  { "williamboman/mason.nvim", opts = {} },
  { "williamboman/mason-lspconfig.nvim", opts = {} },
  { "WhoIsSethDaniel/mason-tool-installer.nvim"},
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
  "andweeb/presence.nvim",
  opts = {
    show_time = true,
    buttons = true,
    enable_line_number = true,
  },
},

    -- Basic plugins
  { "nvim-lualine/lualine.nvim", lazy = false },
  { "nvim-tree/nvim-tree.lua", lazy = false },
  { "karb94/neoscroll.nvim", lazy = false },
  { "lambdalisue/suda.vim", lazy = false },
  { "numToStr/Comment.nvim", lazy = false},
  { "mg979/vim-visual-multi", lazy = false},

  { "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate',
    opts = {
      highlight = {
        enable = true,
      },
      indent = {enable = true},
      auto_install = true,
      ensure_installed = {
        'lua',
    },
  },
    config = function (_, opts)
  local configs = require("nvim-treesitter.configs")
  configs.setup(opts)
    end
  },
  { "nvim-telescope/telescope.nvim", lazy = false },
--{
--  'fisadev/vim-isort',
--  ft = 'python',
--  config = function()
--    -- Ensure Python support is available
--    local python_support = vim.fn.has('python3')
--    if python_support == 1 then
--      vim.g.vim_isort_map = ''
--      vim.api.nvim_create_autocmd({"BufWritePre"}, {
--        pattern = "*.py",
--       callback = function()
--          vim.cmd("Isort")
--        end,
--      })
--    else
--     print("Python3 support is missing, vim-isort will be disabled.")
--    end
--  end
--},

  {
  'psf/black',
  ft = 'python',
  config = function ()
    vim.api.nvim_create_autocmd({"BufWritePre"}, {
      pattern = "*.py",
      callback = function()
        vim.cmd("Black")
      end,
    })
    end
  },
  {
    "xiyaowong/transparent.nvim",
    lazy = false, -- Disable lazy-loading
    priority = 1000, -- High priority to ensure it loads before other plugins
    config = function()
      require("transparent").setup({
        extra_groups = { -- Example groups to clear
          "NormalFloat", -- Add more highlight groups as needed
          "NvimTreeNormal",
        },
        exclude = {}, -- Groups you want to keep intact
      })
    end,
  },

  {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot", -- Makes `:Copilot` available
  event = "InsertEnter", -- Load when entering Insert mode
  config = function()
    require("copilot").setup({
      suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<TAB>",
            dismiss = "<C-e>",
          },
      },
    })
  end,
  },
  {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua", "nvim-cmp" }, -- Ensure it loads after copilot and nvim-cmp
  config = function()
    require("copilot_cmp").setup()
  end,
  },

  -- Rust vim Plugin
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function ()
      local mason_registry = require('mason-registry')
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path.. "lldb/lib/liblldb.dylib"
      local cfg = require('rustaceanvim.config')

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
        },
      }
    end
  },

  -- CopilotChat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      -- Add any specific options here
    },
    build = nil, -- Disable the build step
  },

  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },

  {
    'mfussenegger/nvim-dap',
    config = function ()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
		end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      require("dapui").setup()
    end,
  },
    {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },
}
