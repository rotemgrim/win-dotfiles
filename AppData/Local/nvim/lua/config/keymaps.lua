-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- keymaps
local map = vim.keymap.set

-- comment like in intellij
map("n", "<c-/>", "<cmd>normal gcc<cr>j", { desc = "Comment line" })
map("n", "<c-_>", "<cmd>normal gcc<cr>j", { desc = "Comment line" })
map("v", "<c-/>", "<cmd>normal gcc<cr>", { desc = "Comment Block" })
map("v", "<c-_>", "<cmd>normal gcc<cr>", { desc = "Comment Block" })
