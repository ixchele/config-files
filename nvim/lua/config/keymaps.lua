-- ============================================
-- Keymaps configuration file
-- Author: ixchele
-- ============================================

-- Shorten function name
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ========================
-- General Keymaps
-- ========================
-- Space as leader key
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Disable default space behavior
keymap({ "n", "v" }, "<Space>", "<Nop>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts) -- Move to left window
keymap("n", "<C-j>", "<C-w>j", opts) -- Move to bottom window
keymap("n", "<C-k>", "<C-w>k", opts) -- Move to top window
keymap("n", "<C-l>", "<C-w>l", opts) -- Move to right window

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- ========================
-- Text Editing
-- ========================
-- Keep selection after indenting in visual mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move selected lines up/down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Paste without losing clipboard content
keymap("v", "p", '"_dP', opts)

-- ========================
-- Clipboard
-- ========================
-- Copy to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+Y', opts)

-- Delete without yanking
keymap({ "n", "v" }, "<leader>d", '"_d', opts)

-- ========================
-- File Operations
-- ========================
-- Save file
keymap("n", "<leader>w", ":w<CR>", opts)

-- Quit file
keymap("n", "<leader>q", ":q<CR>", opts)

-- Save and quit
keymap("n", "<leader>x", ":wq<CR>", opts)

-- ========================
-- Plugins
-- ========================
-- Oil.nvim
keymap("n", "-", ":Oil --float<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

-- GitSigns
keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", opts)

-- ========================
-- Miscellaneous
-- ========================
-- Clear search highlights
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Toggle spell checking
keymap("n", "<leader>ss", ":set spell!<CR>", opts)

-- Fast exit from insert mode
keymap("i", "jk", "<ESC>", opts)

