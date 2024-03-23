require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    custom = { "^.git$" },
  },
})

vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFindFileToggle<CR>", { desc = "Toggle nvim tree" })
