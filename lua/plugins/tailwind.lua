-- lua/plugins/tailwind.lua
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")

			-- TailwindCSS LSP
			lspconfig.tailwindcss.setup({
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								-- Add regex patterns for frameworks (e.g., clsx, tw, cva)
								{ "clsx\\(([^)]*)\\)", "'([^']*)'" },
								{ "cva\\(([^)]*)\\)", "'([^']*)'" },
							},
						},
					},
				},
			})
		end,
	},
}
