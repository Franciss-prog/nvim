local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
    yaml = { "prettier" },
    svelte = { "prettierd" },
    python = { "black" }, -- Switched to black for Python formatting
  },
  formatters = {
    black = {
      command = "black",
      args = {
        "--line-length=88",
        "--skip-string-normalization",
        "--fast",
        "$FILENAME",
      },
      stdin = false,
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
