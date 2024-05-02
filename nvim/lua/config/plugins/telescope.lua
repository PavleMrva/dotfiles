return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			-- This will not install any breaking changes.
			-- For major updates, this must be adjusted manually.
			version = "^1.0.0",
		},
		{
			"nvim-telescope/telescope-project.nvim",
		},
	},
	config = function()
		-- Enable telescope fzf native, if installed
		local telescope = require("telescope")
		local project_actions = require("telescope._extensions.project.actions")

		telescope.load_extension("harpoon")
		telescope.load_extension("live_grep_args")
		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				project = {
					base_dirs = {
						-- { "~/igp-projects", max_depth = 2 },
						-- { "~/samepay-projects", max_depth = 2 },
						{ "~/logic", max_depth = 2 },
					},

					hidden_files = true, -- default: false
					theme = "dropdown",
					order_by = "asc",
					search_by = "title",
					sync_with_nvim_tree = true, -- default false
					-- default for on_project_selected = find project files
					on_project_selected = function(prompt_bufnr)
						-- Do anything you want in here. For example:
						project_actions.change_working_directory(prompt_bufnr, false)
						require("harpoon.ui").nav_file(1)
					end,
				},
			},
		})

		-- Enable telescope extensions, if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "git-worktree")
		pcall(require("telescope").load_extension, "project")
	end,
}
