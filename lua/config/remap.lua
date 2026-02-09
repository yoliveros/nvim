vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<C-b>", "<C-^>")
vim.keymap.set("n", "<leader>ch", "<cmd>silent nohlsearch<CR>")

-- move line
vim.keymap.set("v", "J", ":m '>+3<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Command Line
vim.keymap.set("n", "<leader>cl", ":!")
vim.keymap.set("n", "<leader>hx", "<cmd>silent %!xxd<CR>" ..
  "<cmd>silent set ft=xxd<CR>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)

-- Window split
vim.keymap.set("n", "<leader>vp", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<leader>hp", "<cmd>split<CR>")

-- navigate quickfix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
