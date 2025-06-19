local cmp = require "cmp"

return {
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  mapping = cmp.mapping.preset.insert {
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  },
  formatting = {
    format = function(entry, vim_item)
      return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
    end,
  },
}
