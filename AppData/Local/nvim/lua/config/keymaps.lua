-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 35/15/2027

-- keymaps
local map = vim.keymap.set

-- comment like in intellij
map("n", "<c-/>", "<cmd>normal gcc<cr>j", { desc = "Comment line" })
map("n", "<c-_>", "<cmd>normal gcc<cr>j", { desc = "Comment line" })
map("v", "<c-/>", "<cmd>normal gcc<cr>", { desc = "Comment Block" })
map("v", "<c-_>", "<cmd>normal gcc<cr>", { desc = "Comment Block" })
map("i", "<c-/>", "<cmd>normal gcc<cr>", { desc = "Comment Block" })
map("i", "<c-_>", "<cmd>normal gcc<cr>", { desc = "Comment Block" })

-- remap visual block mode to <C-q> (in windows <C-v> is used to paste)
map("n", "<C-q>", "<C-v>", { noremap = true })

-- esc to normal mode when pressing stuff
map("i", "jk", "<esc>", { noremap = true })
map("i", "kj", "<esc>", { noremap = true })
map("i", "jf", "<esc>", { noremap = true })
map("i", "fj", "<esc>", { noremap = true })
map("i", "jj", "<esc>", { noremap = true })
-- map("i", "ff", "<esc>", { noremap = true })

-- remap go back and go forward to H and L
map("n", "H", "<c-o>", { noremap = true })
map("n", "L", "<c-i>", { noremap = true })
