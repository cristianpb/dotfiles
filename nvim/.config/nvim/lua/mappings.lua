require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<C-n>", vim.cmd.bnext, { desc = "󰽙 Next buffer" })
map("n", "<C-p>", vim.cmd.bprevious, { desc = "󰽙 Previous buffer" })

map("n", "<F3>", ":NvimTreeToggle<CR>", { desc = "NvimTree Toggle" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
