return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		opts = {
			transparent_mode = true,
		},
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			on_palette = function(palette)
				-- palette["gray2"] = "#ffffff"
				return palette
			end,
			transparent_bg = true,
			cursorline = {
				blend = 0.1,
			},
		},
	},
}
