-- Enable telescope fzf native, if installed
-- pcall(require('telescope').load_extension, 'fzf')
local telescope = require("telescope")

telescope.load_extension("harpoon")
telescope.load_extension("live_grep_args")
telescope.setup({
  defaults = {
    file_ignore_patterns = {
      "node_modules",
    },
  },
})

local telescope_builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>?", telescope_builtin.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", telescope_builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  telescope_builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>fj", "<CMD>Telescope find_files hidden=true<CR>", { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set(
  "n",
  "<leader>fg",
  ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "[S]earch by [G]rep" }
)
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "[S]earch [H]elp" })
