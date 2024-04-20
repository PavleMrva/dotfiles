vim.keymap.set("n", "<leader>dgt", function()
  require("dap-go").debug_test()
end, { desc = "[D]ebug [G]o [T]est" })

vim.keymap.set("n", "<leader>dgl", function()
  require("dap-go").debug_last()
end, { desc = "[D]ebug [G]o [L]ast" })
