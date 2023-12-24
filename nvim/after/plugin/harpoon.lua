local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle harpoon menu" })

vim.keymap.set("n", "<leader>hn", ui.nav_next, { desc = "Go to next mark" })
vim.keymap.set("n", "<leader>hp", ui.nav_prev, { desc = "Go to next mark" })
