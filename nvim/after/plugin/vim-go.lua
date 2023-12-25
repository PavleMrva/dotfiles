-- keys = {
--   { "<leader>gife", "<cmd> GoIfErr<CR>",       desc = "Add if error block" },
--   { "<leader>gfs",  "<cmd> GoFillStruct<CR>",  desc = "Fill in Go Struct" },
--   { "<leader>gsj",  "<cmd> GoAddTag json<CR>", desc = "Add json struct tags" },
--   { "<leader>gsy",  "<cmd> GoAddTag yaml<CR>", desc = "Add yaml struct tags" },
-- },
--
--
vim.keymap.set("n", "<leader>gife", "<cmd> GoIfErr<CR>", { desc = "Add if error block" })
vim.keymap.set("n", "<leader>gfs", "<cmd> GoFillStruct<CR>", { desc = "Fill in Go Struct" })
vim.keymap.set("n", "<leader>gsj", "<cmd> GoAddTag json<CR>", { desc = "Add json struct tags" })
vim.keymap.set("n", "<leader>gsy", "<cmd> GoAddTag yaml<CR>", { desc = "Add yaml struct tags" })
vim.keymap.set("n", "<leader>gg", "<cmd> GoGenerate<CR>", { desc = "Add yaml struct tags" })
