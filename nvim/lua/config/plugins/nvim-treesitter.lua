return {
	{
		"nvim-treesitter/playground",
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "nvim-treesitter/nvim-treesitter-context" },
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"dockerfile",
				"go",
				"html",
				"javascript",
				"lua",
				"markdown",
				"python",
				"query",
				"sql",
				"typescript",
				"vim",
				"vimdoc",
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		build = ":TSUpdate",
		opts = {
			-- A list of parser names, or "all" (the five listed parsers should always be installed)
			--
			ensure_installed = {
				"dockerfile",
				"go",
				"html",
				"javascript",
				"lua",
				"markdown",
				"python",
				"query",
				"sql",
				"typescript",
				"vim",
				"vimdoc",
			},

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
			-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

			highlight = {
				enable = true,

				-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
				-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
				-- the name of the parser)
				-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			textobjects = {
				select = {
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = { query = "@function.outer", desc = "Select outer part of function region" },
						["if"] = { query = "@function.inner", desc = "Select inner part of function region" },
						["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
						-- You can optionally set descriptions to the mappings (used in the desc parameter of
						-- nvim_buf_set_keymap) which plugins like which-key display
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						-- You can also use captures from other query groups like `locals.scm`
						["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = { query = "@function.outer", desc = "Next function start" },
						["]]"] = { query = "@class.outer", desc = "Next class start" },
						--
						-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
						["]o"] = { query = "@loop.*", desc = "" },
						-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
						--
						-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
						-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
						["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
					},
					goto_next_end = {
						["]M"] = { query = "@function.outer", desc = "Next function end" },
						["]["] = { query = "@class.outer", desc = "Next class end" },
					},
					goto_previous_start = {
						["[m"] = { query = "@function.outer", desc = "Previous function start" },
						["[["] = { query = "@class.outer", desc = "Previous class start" },
					},
					goto_previous_end = {
						["[M"] = { query = "@function.outer", desc = "Previous function end" },
						["[]"] = { query = "@class.outer", desc = "Previous class end" },
					},
					-- Below will go to either the start or the end, whichever is closer.
					-- Use if you want more granular movements
					-- Make it even more gradual by adding multiple queries and regex.
					goto_next = {
						["]d"] = { query = "@conditional.outer", desc = "Next conditional" },
					},
					goto_previous = {
						["[d"] = { query = "@conditional.outer", desc = "Previous conditional" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			vim.treesitter.language.register("markdown", "mdx")
		end,
	},
}
