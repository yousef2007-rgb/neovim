return {
  -- LSP + Mason + lsp-zero
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      {"neovim/nvim-lspconfig"},
      {"williamboman/mason.nvim"},
      {"williamboman/mason-lspconfig.nvim"},
      {"jose-elias-alvarez/typescript.nvim"},
    },
    config = function()
      local lsp = require("lsp-zero").preset({
        name = "recommended",
        manage_nvim_cmp = false, -- we'll use Blink CMP instead
        suggest_lsp_servers = false,
      })

      -- Mason setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "eslint", "lua_ls", "tailwindcss" },
      })

      -- TypeScript + ts_ls
      require("typescript").setup({
        server = {
          on_attach = function(client, bufnr)
            local opts = { buffer = bufnr }
            local map = vim.keymap.set

            -- VS Code style LSP keymaps
            map("n", "gd", vim.lsp.buf.definition, opts)
            map("n", "K", vim.lsp.buf.hover, opts)
            map("n", "gi", vim.lsp.buf.implementation, opts)
            map("n", "<leader>D", vim.lsp.buf.type_definition, opts)
            map("n", "<leader>rn", vim.lsp.buf.rename, opts)
            map("n", "gr", vim.lsp.buf.references, opts)
            map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
            map("n", "<leader>f", function()
              vim.lsp.buf.format({ timeout_ms = 10000 })
            end, opts)
          end,
        },
      })

      -- Lua LS settings
      lsp.configure("lua_ls", {
        settings = {
          Lua = {
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            diagnostics = { globals = {"vim"} },
          },
        },
      })

      -- TailwindCSS LSP
      lsp.configure("tailwindcss", {
        root_dir = require("lspconfig.util").root_pattern(
          "tailwind.config.js",
          "tailwind.config.ts",
          "postcss.config.js",
          "package.json",
          ".git"
        ),
      })

      -- ESLint LSP
      lsp.configure("eslint", {
        root_dir = require("lspconfig.util").root_pattern(
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.json",
          "package.json",
          ".git"
        ),
      })

      lsp.setup()
    end,
  },

  -- Blink CMP for completion
  {
    "Saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
      "kristijanhusak/vim-dadbod-ui",
    },
    opts = {
      snippets = { preset = "luasnip" },
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<C-Space>"] = { "show" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      completion = {
        menu = {
          auto_show = true,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "kind_icon", "label", "label_description", gap = 1 },
              { "kind" },
            },
          },
        },
        documentation = { auto_show = true },
      },
      signature = { enabled = true },
      fuzzy = { implementation = "lua" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          sql = { "snippets", "dadbod", "buffer" },
        },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
    },
    config = function(_, opts)
      require("luasnip.loaders.from_vscode").load()
      require("blink.cmp").setup(opts)
    end,
  },
}

