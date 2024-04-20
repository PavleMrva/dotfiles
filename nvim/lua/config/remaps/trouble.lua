local trouble = require("trouble")

vim.keymap.set("n", "<leader>to", function()
  trouble.open()
end, { desc = "[T]rouble [O]pen" })

vim.keymap.set("n", "<leader>tw", function()
  trouble.open("workspace_diagnostics")
end, { desc = "[T]rouble [W]orkspace diagnostics open" })

vim.keymap.set("n", "<leader>td", function()
  trouble.open("document_diagnostics")
end, { desc = "[T]rouble [D]ocument diagnostics" })

vim.keymap.set("n", "<leader>tq", function()
  trouble.open("quickfix")
end, { desc = "[T]rouble [Q]uickfix" })

vim.keymap.set("n", "<leader>xl", function()
  trouble.open("loclist")
end, { desc = "[T]rouble [L]oclist" })
