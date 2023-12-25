_G.theme = "nordic"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

require("plugins.init")

vim.g.go_def_mode = "guru"
vim.g.go_addtags_transform = "snakecase"

-- Enable telescope theme
vim.g.gruvbox_baby_telescope_theme = 1

-- Enable transparent mode
vim.g.gruvbox_baby_transparent_mode = 1

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.softtabstop = 2
vim.opt.scrolloff = 5

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
-- Enable automatic writing of all buffers when leaving or executing external commands
vim.o.autowriteall = true

vim.wo.relativenumber = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 50
vim.o.timeoutlen = 300

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.keymap.set("n", "<leader>p", '"_dP', { desc = "Paste without register" })

require("custom.configs.lspconfig")

vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

vim.cmd([[let g:terraform_fmt_on_save=1]])
vim.cmd([[let g:terraform_align=1]])
