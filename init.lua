vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
os.execute "python ~/.config/nvim/pywal/chadwal.py &> /dev/null &"

local autocmd = vim.api.nvim_create_autocmd

autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = function()
    require("nvchad.utils").reload()
  end,
})

-- Diagnostic config (runs at startup, no matter what)
vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  float = {
    border = "rounded",
    source = "always",
  },
  severity_sort = true,
}

-- Ensure it reapplies when LSP attaches (prevents overrides)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.diagnostic.config {
      virtual_text = { prefix = "●" },
      float = { border = "rounded", source = "always" },
      severity_sort = true,
    }
  end,
})

-- Auto popup diagnostics on hover
vim.o.updatetime = 250
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      border = "rounded",
      source = "always",
      prefix = "",
    })
  end,
})
