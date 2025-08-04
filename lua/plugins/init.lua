return {

  -- LSP / Mason
  { "williamboman/mason.nvim", opts = {} },
  { "williamboman/mason-lspconfig.nvim", opts = {} },
  { "WhoIsSethDaniel/mason-tool-installer.nvim"},
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- Misc
  {
  "IogaMaster/neocord",
  opts = {
    show_time = true,
    buttons = true,
    enable_line_number = true,
    global_timer = true,
    },
},

    -- Basic plugins
  { "nvim-lualine/lualine.nvim", lazy = false },
  { "nvim-tree/nvim-tree.lua", enabled = false },
  { "lambdalisue/suda.vim", lazy = true },
  { "numToStr/Comment.nvim", lazy = true},
  -- { "mg979/vim-visual-multi", lazy = false},
  { "tpope/vim-fugitive", lazy = false},
  { "folke/persistence.nvim",
    event = "BufReadPre",
    config = true,
  },
  {
  "karb94/neoscroll.nvim",
  lazy = true,
  opts = {
    hide_cursor = true,
    stop_eof = true,
    respect_scrolloff = true,
    cursor_scrolls_alone = true,
    },
	},
  {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  explorer = {
    enabled = true,
    auto_close = true,
  },
  indent = { enabled = false },
  input = { enabled = true },
  picker = {enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  -- scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
    },
  },

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


  { "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = {
      { "BurntSushi/ripgrep" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      config = function()
        -- vim.keymap.set("n", "<leader>ff", require ('telescope.builtin').find_files)
        -- vim.keymap.set("n", "<leader>fw", require ('telescope.builtin').live_grep)
        require('telescope.builtin').find_files()
      end
    }
  },

  {
    "xiyaowong/transparent.nvim",
    lazy = false, -- Disable lazy-loading
    priority = 1000, -- High priority to ensure it loads before other plugins
    config = function()
      require("transparent").setup({
        exclude = {}, -- Groups you want to keep intact
      })
    end,
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

  -- AI

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
            accept = "<C-y>",
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


  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    show_diff = {
      full_diff = true
    },
    opts = {
      model = "claude-3.7-sonnet",
      context = "buffer",
      border = "rounded",
      auto_insert_mode = true,
      show_help = false,
      mappings = {
        submit_prompt = {
          insert = '<C-CR>',
      },
    },
    },
    build = nil, -- Disable the build step
  },


  -- PYTHON


  -- RUST

  {
    'mrcjkb/rustaceanvim',
    lazy = false,
    version = '^6',
    config = function()
      local extension_path = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/codelldb/extension")
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


    {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
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
