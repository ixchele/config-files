-- Highlight Yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight yank", {clear = true}),
	callback = function ()
		vim.highlight.on_yank()
	end

})

-- Open Help in Vertical Split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})
