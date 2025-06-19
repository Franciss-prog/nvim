require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html", -- HTML
  "cssls", -- CSS
  "tsserver", -- JS/TS/React
  "eslint", -- JS/TS/React linting
  "pyright", -- Python
  "rust_analyzer", -- Rust
  "clangd", -- C/C++
  "lua_ls", -- Lua
  "gopls", -- Go
  "jsonls", -- JSON
  "yamlls", -- YAML
  "bashls", -- Bash
  "svelte", -- Svelte
  "dockerls", -- Docker
  "tailwindcss",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
