return {
	-- Ensure required tools are installed
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"pyright", -- LSP for Python
				"ruff", -- Linter
				"black", -- Code formatter
				"isort", -- Import sorter
				"debugpy", -- Debugger for DAP
			})
		end,
	},

	-- Python LSP configuration
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {
					settings = {
						python = {
							analysis = {
								autoImportCompletions = true,
								typeCheckingMode = "off", -- Set to "strict" for stricter type checking
							},
						},
					},
				},
			},
		},
	},

	-- Format on save using Black and isort
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				python = { "black", "isort" },
			},
		},
	},

	-- Linting with Ruff
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				python = { "ruff" },
			},
		},
	},

	-- Debugging setup with nvim-dap
}
