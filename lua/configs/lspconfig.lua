local lspconfig = require "lspconfig"
local nvchad_config = require "nvchad.configs.lspconfig"

-- Apply NvChad's default on_attach and capabilities
local on_attach = nvchad_config.on_attach
local capabilities = nvchad_config.capabilities

-- Servers that don’t need extra customization
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
  "dockerls",
  "tailwindcss",
  "jdtls",
  "intelephense",
}

-- Set up generic servers
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- TypeScript / JavaScript LSP
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  settings = {
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
  },
}

-- Svelte LSP
lspconfig.svelte.setup {
  cmd = { "svelteserver", "--stdio" }, -- or adjust to your node_modules path
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "svelte" },
  root_dir = lspconfig.util.root_pattern("package.json", ".git"),
}

-- Astro LSP
lspconfig.astro.setup {
  cmd = { "astro-ls", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "astro" },
  root_dir = lspconfig.util.root_pattern("package.json", ".git"),
  init_options = {
    typescript = {
      tsdk = "/usr/lib/node_modules/typescript/lib", -- adjust if needed
    },
  },
}

-- PHP LSP
lspconfig.intelephense.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "intelephense", "--stdio" }, -- make sure this path works
  root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
  settings = {
    intelephense = {
      files = {
        maxSize = 5000000,
      },
    },
  },
}
