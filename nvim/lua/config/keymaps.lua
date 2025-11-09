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
keymap({ "n", "v" }, "<Space>", "<Nop>", { desc = "Leader key placeholder", noremap=true, silent=true })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window", noremap=true, silent=true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window", noremap=true, silent=true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window", noremap=true, silent=true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window", noremap=true, silent=true })

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window smaller vertically", noremap=true, silent=true })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window larger vertically", noremap=true, silent=true })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window smaller horizontally", noremap=true, silent=true })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window larger horizontally", noremap=true, silent=true })

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Go to next buffer", noremap=true, silent=true })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Go to previous buffer", noremap=true, silent=true })

-- ========================
-- Text Editing
-- ========================
-- Keep selection after indenting in visual mode
keymap("v", "<", "<gv", { desc = "Indent left and reselect", noremap=true, silent=true })
keymap("v", ">", ">gv", { desc = "Indent right and reselect", noremap=true, silent=true })

-- Move selected lines up/down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", noremap=true, silent=true })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", noremap=true, silent=true })

-- Paste without losing clipboard content
keymap("v", "p", '"_dP', { desc = "Paste over selection without overwriting register", noremap=true, silent=true })

-- ========================
-- Clipboard
-- ========================
-- Copy to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard", noremap=true, silent=true })
keymap("n", "<leader>Y", '"+Y', { desc = "Copy line to system clipboard", noremap=true, silent=true })

-- Delete without yanking
keymap({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without copying", noremap=true, silent=true })

-- ========================
-- File Operations
-- ========================
-- Save file
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file", noremap=true, silent=true })

-- Quit file
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit file", noremap=true, silent=true })

-- Save and quit
keymap("n", "<leader>x", ":wq<CR>", { desc = "Save and quit", noremap=true, silent=true })

-- ========================
-- Plugins
-- ========================
-- Oil.nvim
keymap("n", "-", ":Oil --float<CR>", { desc = "Open Oil floating file explorer", noremap=true, silent=true })

-- Toggleterm
    keymap("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle floating terminal" })
    keymap("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
    keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files", noremap=true, silent=true })
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep", noremap=true, silent=true })
keymap("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "List buffers", noremap=true, silent=true })
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Search help tags", noremap=true, silent=true })

-- GitSigns
keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git blame line", noremap=true, silent=true })
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk", noremap=true, silent=true })
keymap("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset git hunk", noremap=true, silent=true })

-- ========================
-- Miscellaneous
-- ========================
-- Clear search highlights
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight", noremap=true, silent=true })

-- Toggle spell checking
keymap("n", "<leader>ss", ":set spell!<CR>", { desc = "Toggle spell check", noremap=true, silent=true })

-- Fast exit from insert mode
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode quickly", noremap=true, silent=true })

-- Open diagnostics in floating window
keymap("n", "gl", function() vim.diagnostic.open_float() end, { desc = "Open diagnostics in float", noremap=true, silent=true })

