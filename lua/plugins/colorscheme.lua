return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true, -- Enable transparency
			-- You can add other settings here
		},
		config = function()
			require("tokyonight").setup({
				transparent = true, -- Ensure this is also set here
				-- Add other settings if needed
			})
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	-- Uncomment this if you want to use Sonokai as well:
	-- {
	--   "sainnhe/sonokai",
	--   priority = 1000,
	--   config = function()
	--     vim.g.sonokai_transparent_background = 1
	--     vim.g.sonokai_enable_italic = 1
	--     vim.g.sonokai_style = "andromeda"
	--     vim.cmd([[colorscheme sonokai]])
	--   end,
	-- },
}
