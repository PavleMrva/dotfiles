local trouble = require("trouble")

vim.keymap.set("n", "<leader>xx", function()
  trouble.open()
end)

vim.keymap.set("n", "<leader>xw", function()
  trouble.open("workspace_diagnostics")
end)

vim.keymap.set("n", "<leader>xd", function()
  trouble.open("document_diagnostics")
end)

vim.keymap.set("n", "<leader>xq", function()
  trouble.open("quickfix")
end)

vim.keymap.set("n", "<leader>xl", function()
  trouble.open("loclist")
end)
