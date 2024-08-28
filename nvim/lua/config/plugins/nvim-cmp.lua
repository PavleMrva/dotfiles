return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			-- snippet plugin
			"L3MON4D3/LuaSnip",
			-- dependencies = "rafamadriz/friendly-snippets",
			version = "v2.*",
			run = "make install_jsregexp",
		},
		{
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		},
		-- autopairing of (){}[] etc
		{
			"windwp/nvim-autopairs",
			config = function()
				local nvim_autopairs = require("nvim-autopairs")
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				local cmp = require("cmp")

				nvim_autopairs.setup({
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				})

				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
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
			"onsails/lspkind.nvim", -- VSCode-like pictograms
		},
	},
	config = function()
		-- Set up nvim-cmp.
		local cmp = require("cmp")

		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					border = "rounded",
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:Folded,Search:None",
				}),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				format = require("lspkind").cmp_format({
					mode = "symbol_text",
					menu = {
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[Latex]",
					},
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "cody" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = "buffer" },
			}),
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		-- Database completion
		vim.api.nvim_exec(
			[[
      autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
      autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
  ]],
			false
		)
	end,
}
