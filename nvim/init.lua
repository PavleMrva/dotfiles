_G.theme = "gruvbox"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = false

vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.opt.conceallevel = 1

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "U", "<C-r>", { noremap = true })

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.softtabstop = 2
vim.opt.scrolloff = 5

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0

-- Set highlight on search
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Enable automatic writing of all buffers when leaving or executing external commands
vim.opt.autowriteall = true

vim.wo.relativenumber = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 50
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

vim.keymap.set("n", "<leader>p", '"_dP', { desc = "Paste without register" })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require("config.lazy_init")

vim.cmd.colorscheme(_G.theme)

require("config.remaps")

vim.g.go_def_mode = "guru"
vim.g.go_addtags_transform = "snakecase"

-- require("custom.configs.lspconfig")

vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

vim.cmd([[let g:terraform_fmt_on_save=1]])
