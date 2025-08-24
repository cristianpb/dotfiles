return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        PATH = "prepend", -- "skip" seems to cause the spawning error
        ui = {
          icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ",
          },
        },
        max_concurrent_installers = 10,
      })
    end,
  },
  --{
  --  "williamboman/mason-lspconfig.nvim",
  --  lazy = false,
  --  opts = {
  --    auto_install = true,
  --  },
  --  config = function()
  --    vim.lsp.config('ruff', {
  --      init_options = {
  --        settings = {
  --          -- Ruff language server settings go here
  --        }
  --      }
  --    })
  --    vim.lsp.enable('ruff')
  --  end,
  --},
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "ruff",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.clangd.setup({ capabilities = capabilities })

            local on_attach_pyright = function(client, _)
        -- Disable all capabilities except hoverProvider
        -- client.server_capabilities.completionProvider = false
        -- client.server_capabilities.definitionProvider = false
        -- client.server_capabilities.typeDefinitionProvider = false
        -- client.server_capabilities.implementationProvider = false
        -- client.server_capabilities.referencesProvider = false
        -- client.server_capabilities.documentSymbolProvider = false
        -- client.server_capabilities.workspaceSymbolProvider = false
        -- client.server_capabilities.codeActionProvider = false
        -- client.server_capabilities.documentFormattingProvider = false
        -- client.server_capabilities.documentRangeFormattingProvider = false
        -- client.server_capabilities.renameProvider = false
        -- client.server_capabilities.signatureHelpProvider = false
        -- client.server_capabilities.documentHighlightProvider = false
        -- client.server_capabilities.foldingRangeProvider = false
        -- client.server_capabilities.semanticTokensProvider = false
        -- client.server_capabilities.declarationProvider = false
        -- client.server_capabilities.callHierarchyProvider = false
        -- client.server_capabilities.diagnosticProvider = false

        -- Enable hoverProvider
        client.server_capabilities.hoverProvider = true
      end


      -- Configure pyright
      lspconfig.pyright.setup({
        on_attach = on_attach_pyright,
        capabilities = (function()
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
          return capabilities
        end)(),
        settings = {
          python = {
            analysis = {
              useLibraryCodeForTypes = true,
              diagnosticSeverityOverrides = {
                reportUnusedVariable = "warning",
              },
              typeCheckingMode = "on", -- Set type-checking mode to off
              diagnosticMode = "off", -- Disable diagnostics entirely
            },
          },
        },
      })

      local on_attach_ruff = function(client, _)
        if client.name == "ruff" then
          -- disable hover in favor of pyright
          client.server_capabilities.hoverProvider = true
        end
      end

      lspconfig.ruff.setup({
        --on_attach = on_attach_ruff,
        init_options = {
          settings = {
            args = {
              "--ignore",
              "F821",
              "--ignore",
              "E402",
              "--ignore",
              "E722",
              "--ignore",
              "E712",
            },
          },
        },
      })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        width = 70,
        height = 15,
      })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
  {
    "allaman/emoji.nvim",
    version = "1.0.0", -- optionally pin to a tag
    ft = {"markdown", "gitcommit", "vimwiki", "mail"}, -- adjust to your needs
    dependencies = {
      -- util for handling paths
      "nvim-lua/plenary.nvim",
      -- optional for nvim-cmp integration
      "hrsh7th/nvim-cmp",
      -- optional for telescope integration
      --"nvim-telescope/telescope.nvim",
      -- optional for fzf-lua integration via vim.ui.select
      --"ibhagwan/fzf-lua",
    },
    opts = {
      -- default is false, also needed for blink.cmp integration!
      enable_cmp_integration = true,
      -- optional if your plugin installation directory
      -- is not vim.fn.stdpath("data") .. "/lazy/
      -- plugin_path = vim.fn.expand("$HOME/plugins/"),
    },
    config = function(_, opts)
      require("emoji").setup(opts)
      -- optional for telescope integration
      local ts = require('telescope').load_extension 'emoji'
      vim.keymap.set('n', '<leader>se', ts.emoji, { desc = '[S]earch [E]moji' })
    end,
  },
  {
    -- The plugin location on GitHub
    "vimwiki/vimwiki",
    --lazy = false,
    -- The event that triggers the plugin
    --event = "BufEnter *.md",
    ---- The keys that trigger the plugin
    keys = { "<leader>w<leader>w", "<leader>ww", "<leader>wt" },
    -- The configuration for the plugin
    init = function () --replace 'config' with 'init'
      vim.g.vimwiki_list = {{
        auto_export=1,
        automatic_nested_syntaxes=1,
        path_html='$HOME/Documents/vimwiki/_site',
        path='~/Documents/vimwiki/content',
        template_path='$HOME/Documents/vimwiki/templates/',
        syntax='markdown',
        ext='.md',
        template_default='markdown',
        custom_wiki2html='$HOME/.dotfiles/wiki2html.sh',
        template_ext='.html'
      }}
    end
  }

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
