return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      sections = {
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
      },
    })
  end,
}
