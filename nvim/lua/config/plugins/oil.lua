return {
	"stevearc/oil.nvim",
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	opts = {
		columns = { "icon" },
		view_options = {
			show_hidden = true,
		},
		keymaps = {
			["<C-h>"] = false,
		},
	},
}
