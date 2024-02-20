require("nvim-tree").setup()

vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeToggle<CR>", { desc = "Toggle nvim tree" })
