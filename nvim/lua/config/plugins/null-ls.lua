return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = {
    "python",
    "javascript",
    "typescript",
    "php",
    "go",
    "lua",
  },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      debug = true,

      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.eslint,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.formatting.prettierd.with({
          extra_filetypes = { "svelte" },
        }),
        null_ls.builtins.completion.spell,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.formatting.ruff,
        null_ls.builtins.diagnostics.pycodestyle,
        null_ls.builtins.formatting.terraform_fmt,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })
  end,
}
