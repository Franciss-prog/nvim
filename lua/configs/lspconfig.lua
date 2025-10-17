-- Load NvChad's defaults
local nvchad_config = require "nvchad.configs.lspconfig"
local on_attach = nvchad_config.on_attach
local capabilities = nvchad_config.capabilities

-- Utility to set up a server only when its filetype is opened
local function setup_lsp(name, opts)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = opts.filetypes or name,
    callback = function()
      if not vim.lsp.get_clients({ name = name })[1] then
        vim.lsp.config[name] = vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = capabilities,
        }, opts)
        vim.lsp.start(vim.lsp.config[name])
      end
    end,
  })
end

-- HTML, CSS, JSON, YAML, Bash, Docker, etc.
local generic_servers = {
  html = { filetypes = { "html" } },
  cssls = { filetypes = { "css", "scss", "less" } },
  eslint = { filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" } },
  pyright = { filetypes = { "python" } },
  rust_analyzer = { filetypes = { "rust" } },
  clangd = { filetypes = { "c", "cpp", "objc", "objcpp" } },
  lua_ls = { filetypes = { "lua" } },
  gopls = { filetypes = { "go" } },
  jsonls = { filetypes = { "json" } },
  yamlls = { filetypes = { "yaml", "yml" } },
  bashls = { filetypes = { "sh", "bash" } },
  dockerls = { filetypes = { "Dockerfile", "dockerfile" } },
  tailwindcss = { filetypes = { "html", "css", "javascriptreact", "typescriptreact", "svelte" } },
  jdtls = { filetypes = { "java" } },
  intelephense = { filetypes = { "php" } },
}

for name, opts in pairs(generic_servers) do
  setup_lsp(name, opts)
end

-- TypeScript / JavaScript
setup_lsp("ts_ls", {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
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
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

-- Svelte
setup_lsp("svelte", {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_dir = vim.fs.root(0, { "package.json", ".git" }),
})

-- Astro
setup_lsp("astro", {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_dir = vim.fs.root(0, { "package.json", ".git" }),
  init_options = {
    typescript = { tsdk = "/usr/lib/node_modules/typescript/lib" },
  },
})

-- PHP (intelephense)
setup_lsp("intelephense", {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_dir = vim.fs.root(0, { "composer.json", ".git" }),
  settings = {
    intelephense = { files = { maxSize = 5000000 } },
  },
})
