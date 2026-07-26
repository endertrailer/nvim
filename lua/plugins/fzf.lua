return {
	{
		"ibhagwan/fzf-lua",
		-- optional dependencies, opts, etc.
		keys = {
			{
				"<leader>ff",
				function()
					require("fzf-lua").files({ cwd = vim.fn.getcwd() })
				end,
				desc = "Fuzzy find files in exact CWD",
			},
		},
	},
}
