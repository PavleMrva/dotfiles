-- Enable telescope fzf native, if installed
-- pcall(require('telescope').load_extension, 'fzf')
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")
local lg_args = require("telescope").extensions.live_grep_args

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>si", function()
	builtin.find_files({
		no_ignore = true,
	})
end, { desc = "[S]earch [I]gnored Files" })
vim.keymap.set("n", "<leader>sb", function()
	builtin.find_files({
		cwd = utils.buffer_dir(),
	})
end, { desc = "[S]earch Files from [B]uffer dir" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sa", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sg", lg_args.live_grep_args, { desc = "[S]earch by grep w/ [A]rgs" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "[S]earch [J]umplist)" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

vim.keymap.set("n", "<leader>st", function()
	telescope.extensions.git_worktree.git_worktrees()
	-- <Enter> - switches to that worktree
	-- <c-d> - deletes that worktree
	-- <c-f> - toggles forcing of the next deletion
end, { desc = "[S]earch Git Work[t]rees" })

vim.keymap.set("n", "<leader>ct", function()
	telescope.extensions.git_worktree.create_git_worktree()
	-- <Enter> - switches to that worktree
	-- <c-d> - deletes that worktree
	-- <c-f> - toggles forcing of the next deletion
end, { desc = "[C]reate Git Work[t]rees" })
