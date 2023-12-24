vim.keymap.set("n", "<leader>td", ":Gitsigns toggle_deleted<CR>", { desc = "Toggle deleted lines" })
vim.keymap.set("n", "<leader>tb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle current line blame" })
vim.keymap.set("n", "<leader>hb", ":Gitsigns blame_line<CR>", { desc = "Blame line" })

require("gitsigns").setup()
