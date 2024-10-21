return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { "j-hui/fidget.nvim",       tag = "legacy", opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-T>.
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

        -- Find references for the word under your cursor.
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    local lspconfig = require("lspconfig")

    -- Custom on_attach functions
    -- local eslint_on_attach = function(client, bufnr)
    -- 	vim.api.nvim_create_autocmd("BufWritePre", {
    -- 		buffer = bufnr,
    -- 		command = "EslintFixAll",
    -- 	})
    -- end

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    --
    --  If you want to override the default filetypes that your language server will attach to you can
    --  define the property 'filetypes' to the map in question.
    local servers = {
      -- LSPs
      templ = {
        filetypes = { "templ" },
      },
      sqlls = {
        filetypes = { "sql", "mysql" },
        root_dir = function()
          return vim.loop.cwd()
        end,
      },
      bufls = {
        filetypes = { "proto" },
      },
      -- clangd = {},
      gopls = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          hints = {
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
      },
      pyright = {
        filetypes = { "python" },
      },
      intelephense = {
        filetypes = { "php" },
      },
      terraformls = {
        filetypes = { "tf", "tfvars" },
      },
      zls = {
        filetypes = { "zig" },
      },
      yamlls = {
        filetypes = { "yaml", "yml" },
      },
      -- rust_analyzer = {},
      tailwindcss = {},
      eslint = {
        filetypes = {
          "javascript.mjs",
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
      },
      -- vtsls = {
      -- 	filetypes = {
      -- 		"javascript.mjs",
      -- 		"javascript",
      -- 		"javascriptreact",
      -- 		"javascript.jsx",
      -- 		"typescript",
      -- 		"typescriptreact",
      -- 		"typescript.tsx",
      -- 	},
      -- 	settings = {
      -- 		complete_function_calls = true,
      -- 		vtsls = {
      -- 			enableMoveToFileCodeAction = true,
      -- 			autoUseWorkspaceTsdk = true,
      -- 			experimental = {
      -- 				completion = {
      -- 					enableServerSideFuzzyMatch = true,
      -- 				},
      -- 			},
      -- 		},
      -- 		typescript = {
      -- 			updateImportsOnFileMove = { enabled = "always" },
      -- 			suggest = {
      -- 				completeFunctionCalls = true,
      -- 			},
      -- 			inlayHints = {
      -- 				enumMemberValues = { enabled = true },
      -- 				functionLikeReturnTypes = { enabled = true },
      -- 				parameterNames = { enabled = "literals" },
      -- 				parameterTypes = { enabled = true },
      -- 				propertyDeclarationTypes = { enabled = true },
      -- 				variableTypes = { enabled = false },
      -- 			},
      -- 		},
      -- 	},
      -- },
      tsserver = {
        completions = {
          completeFunctionCalls = true,
        },
        filetypes = {
          "javascript.mjs",
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
      html = { filetypes = { "html", "twig", "hbs" } },

      marksman = {
        filetypes = { "markdown" },
      },

      lua_ls = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
          hint = {
            enable = true,
            arrayIndex = "Enable", -- Show virtual text hints for array indexes
            setType = true,   -- Show virtual text hints for implicit set types
            paramName = "All", -- Show virtual text hints for function parameters
            paramType = true, -- Show virtual text hints for parameter types
            semicolon = "SameLine", -- Show virtual text hints for semicolons
          },
        },
        filetypes = { "lua" },
      },

      bashls = {
        filetypes = { "sh", "zsh" },
      },
    }

    require("mason").setup({})
    require("mason-tool-installer").setup({
      ensure_installed = {
        "black",
        "bufls",
        "docker_compose_language_service",
        "dockerls",
        "eslint-lsp",
        "gofumpt",
        "goimports-reviser",
        "golangci-lint",
        "js-debug-adapter",
        "lua-language-server",
        "mypy",
        "phpactor",
        "prettier",
        "prisma-language-server",
        "ruff",
        "spectral-language-server",
        "sqlls",
        "stylelint_lsp",
        "stylua",
        "svelte",
        "tailwindcss-language-server",
        "yamlls",
      },
    })
    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          if server_name == "tsserver" then
            server_name = "ts_ls"
          end

          local server_config = servers[server_name] or {}

          if server_config.enabled == nil then
            server_config.enabled = true
          end

          local lsp_config = {
            capabilities = capabilities,
            on_attach = on_attach,
            enabled = server_config.enabled,
            settings = server_config,
            filetypes = server_config.filetypes,
            flags = {
              debounce_text_changes = 150,
            },
          }

          -- if server_name == "eslint" then
          -- 	lsp_config.on_attach = eslint_on_attach
          -- end

          lspconfig[server_name].setup(lsp_config)
        end,
      },
    })

    -- additional filetypes
    vim.filetype.add({
      extension = {
        templ = "templ",
        mdx = "mdx",
      },
    })

    -- Format current buffer using LSP.
    vim.api.nvim_create_autocmd({
      -- 'BufWritePre' event triggers just before a buffer is written to file.
      "BufWritePre",
    }, {
      pattern = { "*.templ" },
      callback = function()
        -- Format the current buffer using Neovim's built-in LSP (Language Server Protocol).
        vim.lsp.buf.format()
      end,
    })
  end,
}
