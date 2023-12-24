local dap = require("dap")

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Add breakpoint at line" })
vim.keymap.set("n", "<leader>dbc", dap.continue, { desc = "Start debugger" })
