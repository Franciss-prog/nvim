local lspconfig = require "lspconfig"
local nvchad_config = require "nvchad.configs.lspconfig"

-- Apply NvChad's default on_attach and capabilities
nvchad_config.defaults()

local servers = {
  "html",
  "cssls",
  "eslint",
  "pyright",
  "rust_analyzer",
  "clangd",
  "lua_ls",
  "gopls",
  "jsonls",
  "yamlls",
  "bashls",
  "svelte",
  "dockerls",
  "tailwindcss",
  "ts_ls",
}

-- Configure each server
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvchad_config.on_attach,
    capabilities = nvchad_config.capabilities,
    -- Add ts_ls-specific settings
    settings = lsp == "ts_ls" and {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
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
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    } or {},
  }
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvchad_config.on_attach,
    capabilities = nvchad_config.capabilities,
  }
end

-- Explicit ts_ls setup for TypeScript and SvelteKit
lspconfig.ts_ls.setup {
  on_attach = nvchad_config.on_attach,
  capabilities = nvchad_config.capabilities,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}

-- Ensure svelte only handles .svelte files to avoid conflicts
lspconfig.svelte.setup {
  on_attach = nvchad_config.on_attach,
  capabilities = nvchad_config.capabilities,
  filetypes = { "svelte" },
}
