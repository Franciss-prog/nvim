return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  { import = "nvchad.blink.lazyspec" },
  {
    "hrsh7th/nvim-cmp", -- Add nvim-cmp
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Provides cmp_nvim_lsp
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require "configs.cmp" -- Load your cmp.lua
    end,
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = true,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      document_color = {
        enabled = true,
        kind = "inline",
        inline_symbol = "󰝤 ",
        debounce = 200,
      },
      conceal = {
        enabled = false,
      },
      extension = {
        queries = { "svelte" },
        patterns = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "svelte",
        "python",
        "rust",
        "go",
        "bash",
        "json",
        "yaml",
        "dockerfile",
        "c",
        "cpp",
        "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = { side = "right" },
      actions = {
        open_file = {
          quit_on_open = true,
          resize_window = true,
        },
      },
    },
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {
        debounce_delay = 135,
        execution_message = {
          message = function()
            return ""
          end,
        },
      }
    end,
    event = { "InsertLeave", "TextChanged" },
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
  },
}
