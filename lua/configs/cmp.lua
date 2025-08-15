local cmp = require "cmp"

return {
  sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  mapping = cmp.mapping.preset.insert {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  },
  formatting = {
    format = function(entry, vim_item)
      if entry.source.name == "copilot" then
        vim_item.kind = " [Copilot]"
      end
      return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
    end,
  },
}
