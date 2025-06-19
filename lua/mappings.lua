require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<C-a>", "ggVG", { desc = "select all text" })
map("v", "<C-c>", '"+y', { desc = "copy selection to clipboard" })
map("n", "<C-d>", "yyp", { desc = "duplicate line below" })
map("n", "z", "u", { desc = "undo" })
map("n", "<CR>", "i", { desc = "insert mode with Enter" })

local nomap = vim.keymap.del
nomap("n", "<leader>x")
map("n", "<leader>w", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
