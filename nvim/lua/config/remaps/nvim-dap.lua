local dap, dapui = require("dap"), require("dapui")

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Add [b]reakpoint" })

vim.keymap.set("n", "<leader>B", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Add [B]reakpoint with condition" })

vim.keymap.set("n", "<leader>lp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Add [l]og [p]oint" })

vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "[D]AP [R]EPL" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]AP [C]ontinue" })
vim.keymap.set("n", "<leader>dui", function()
	dapui.toggle()
end, { desc = "Open [D]AP [UI]" })
