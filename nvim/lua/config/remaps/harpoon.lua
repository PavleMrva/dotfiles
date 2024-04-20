local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ah", mark.add_file, { desc = "[A]dd file to [H]arpoon" })
vim.keymap.set("n", "<leader>th", ui.toggle_quick_menu, { desc = "[T]oggle [H]arpoon menu" })

vim.keymap.set("n", "<leader>hn", ui.nav_next, { desc = "Go to [H]arpoon [N]ext mark" })
vim.keymap.set("n", "<leader>hp", ui.nav_prev, { desc = "Go to [H]arpoon [P]revious mark" })
