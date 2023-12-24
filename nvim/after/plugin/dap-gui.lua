local dapgui = require("dapui")

dapgui.setup()

vim.keymap.set("n", "<leader>dui", dapgui.toggle, { desc = "Open debugging sidebar" })
