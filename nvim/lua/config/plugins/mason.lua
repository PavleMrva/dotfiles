return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
  end,
  opts = {
    ensure_installed = {
      "stylua",
      "eslint",
      "black",
      "gofumpt",
      "gofmt",
      "goimports_reviser",
      "golangci_lint",
      "spell",
      "mypy",
      "ruff",
      "phpactor",
      "prettier",
      "svelte-language-server",
    },
  },
}
