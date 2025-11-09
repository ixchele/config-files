return {
  -- amongst your other plugins
"akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
      open_mapping = [[<C-\>]], -- Ouvre/ferme le terminal
      shade_terminals = true,   -- Ajoute un fond légèrement assombri
      shading_factor = 2,
      start_in_insert = true,   -- Démarre en mode insertion
      persist_size = true,
      direction = "float",      -- "horizontal" | "vertical" | "tab" | "float"
      float_opts = {
        border = "curved",      -- Bordures arrondies
        winblend = 0,
      },
    })
	end,
}
