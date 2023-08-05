local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.opt.rtp:prepend(lazypath)

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      { "<C-h>", "<cmd> TmuxNavigateLeft<CR>",  desc = "window left" },
      { "<C-l>", "<cmd> TmuxNavigateRight<CR>", desc = "window right" },
      { "<C-j>", "<cmd> TmuxNavigateDown<CR>",  desc = "window down" },
      { "<C-k>", "<cmd> TmuxNavigateUp<CR>",    desc = "window up" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim",       tag = "legacy", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble
            },
            n = { ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble },
          },
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- please take a look at the readme of the extension you want to configure
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')

      local telescope_builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>?', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', telescope_builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "eslint",
        "black",
        "gofumpt",
        "gofmt",
        "goimports_reviser",
        "golangci_lint",
        "spell",
        "mypy",
        "ruff",
      },
    },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "LuaLS/lua-language-server",
    ft = "lua",
  },
  {
    "sainnhe/gruvbox-material",
  },
  {
    'luisiacc/gruvbox-baby'
  },
  {
    "rebelot/kanagawa.nvim",
  },
  {
    "ayu-theme/ayu-vim",
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate", -- this will ensure that your parsers are always up to date
    config = function()
      require("plugins.treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    'nvim-tree/nvim-web-devicons',
    opts = function()
      return { override = require("custom.ui.icons").devicons }
    end,
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end
  },
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { "<leader>ntf", ":NvimTreeFindFileToggle<CR>", desc = "Toggle nvim-tree from current file" },
      { "<leader>ntt", ":NvimTreeToggle<CR>",         desc = "Toggle nvim-tree" },
    },
    config = function()
      require("nvim-tree").setup()
    end
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    keys = {
      { "<leader>tt", ":ToggleTerm<CR>", desc = "Toggle terminal" },
    },
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>td", ":Gitsigns toggle_deleted<CR>",            desc = "Toggle deleted lines" },
      { "<leader>tb", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle deleted lines" },
      {
        "<leader>hb",
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        desc = "Toggle deleted lines",
      },
    },
    ft = "*",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "tpope/vim-fugitive",
    branch = "master",
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", "<cmd> DapToggleBreakpoint <CR>", desc = "Add breakpoint at line" },
      {
        "<leader>dbc",
        function()
          require("dap").continue()
        end,
        desc = "Start debugger",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
      {
        "<leader>dui",
        function()
          local dapui = require("dapui")
          dapui.toggle()
        end,
        desc = "Open debugging sidebar",
      },
    },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
      {
        "<leader>dgt",
        function()
          require("dap-go").debug_test()
        end,
        desc = "Debug go test",
      },
      {
        "<leader>dgl",
        function()
          require("dap-go").debug_last()
        end,
        desc = "Debug last go test",
      },
    },
    config = function()
      require("dap-go").setup()
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = {
      "python",
      "javascript",
      "typescript",
      "php",
      "go",
      "lua",
    },
    config = function()
      require("plugins.null-ls")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip").config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })

          -- vscode format
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

          -- snipmate format
          require("luasnip.loaders.from_snipmate").load()
          require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

          -- lua format
          require("luasnip.loaders.from_lua").load()
          require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

          vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
              if
                  require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                  and not require("luasnip").session.jump_active
              then
                require("luasnip").unlink_current()
              end
            end,
          })
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
      },
    },
    config = function()
      require("plugins.nvim-cmp")
    end,
  },
  {
    "fatih/vim-go",
    ft = "go",
    keys = {
      { "<leader>gife", "<cmd> GoIfErr<CR>",       desc = "Add if error block" },
      { "<leader>gfs",  "<cmd> GoFillStruct<CR>",  desc = "Fill in Go Struct" },
      { "<leader>gsj",  "<cmd> GoAddTag json<CR>", desc = "Add json struct tags" },
      { "<leader>gsy",  "<cmd> GoAddTag yaml<CR>", desc = "Add yaml struct tags" },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
      vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
      vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
      vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
      vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
      vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require("lualine").setup({
        options = {
          theme = _G.theme
        }
      })
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  }
}

local opts = {}

require("lazy").setup(plugins, opts)
