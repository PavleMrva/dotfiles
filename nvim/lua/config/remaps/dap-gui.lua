local dapgui = require("dapui")

vim.keymap.set("n", "<leader>dui", dapgui.toggle, { desc = "Open [D]AP [UI]" })
