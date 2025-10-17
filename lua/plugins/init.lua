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
      filters = {
        dotfiles = false, -- show .env and other hidden files
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
  {
    "rafamadriz/friendly-snippets",
    config = function()
      -- Load VSCode-style snippets (React, Next.js, etc.)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  -- add this to the file where you setup your other plugins:
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require "neocodeium"
      neocodeium.setup()
      vim.keymap.set("i", "<A-f>", neocodeium.accept)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"
      local action_state = require "telescope.actions.state"

      opts = opts or {}
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          i = {
            ["<C-c>"] = function(prompt_bufnr)
              local entry = action_state.get_selected_entry()
              if entry and entry.value then
                vim.fn.setreg("+", entry.value)
                print("Copied: " .. entry.value)
              else
                print "No entry selected"
              end
            end,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
      })

      return opts
    end,
  },
}
