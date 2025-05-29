return {
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = true,
		-- tag = "v0.9.1",
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"php",
				"css",
				"gitignore",
				"graphql",
				"http",
				"json",
				"scss",
				"sql",
				"vim",
				"lua",
				"c",
				"go",
				"python",
				"ninja",
				"rst",
				"dart",
			},

			ignore_install = { "help", "xml", "printf" },
			highlight = {
				enable = true,
				-- disable = { "html" }, -- Disable for HTML
			},
			indent = {
				enable = true,
				disable = { "dart", "html" },
			},
			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},
		},
	},
}
