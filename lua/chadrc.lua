-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadwal",
  transparency = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.plugins = {
  override_options = {
    ["neovim/nvim-lspconfig"] = {
      servers = {
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
          },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  "tw\\([^)]*\\)", -- Support for `tw()` syntax if used
                  'className="([^"]*)"', -- Match className attributes
                },
              },
            },
          },
        },
      },
    },
    user = {
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        config = true,
      },
    },
  },
}

M.nvdash = { load_on_startup = true }
-- M.ui = {
--   tabufline = {
--     lazyload = false
--   }
-- }

return M
