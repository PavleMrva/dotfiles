vim.keymap.set("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>", { desc = "[T]oggle [D]eleted lines" })
vim.keymap.set(
  "n",
  "<leader>tb",
  "<cmd>Gitsigns toggle_current_line_blame<CR>",
  { desc = "[T]oggle current line [B]lame" }
)
vim.keymap.set("n", "<leader>tp", "<cmd>Gitsigns blame_line<CR>", { desc = "[T]oggle current line Blame [P]opup" })
