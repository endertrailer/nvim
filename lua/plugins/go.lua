return {
	-- Go development plugin
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"saghen/blink.cmp",
		},
		config = function()
			require("go").setup({
				-- Disable go.nvim's internal formatting to prevent conflicts with conform.nvim
				lsp_on_format = false,
				gofumpt = false,

				lsp_keymaps = true, -- Setup default keymaps
				lsp_codelens = true, -- Enable codelens
				dap_debug = true, -- Enable nvim-dap integration
				textobjects = true,

				-- Group all LSP configurations cleanly inside lsp_cfg
				lsp_cfg = {
					capabilities = require("blink.cmp").get_lsp_capabilities(),
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
								unusedwrite = true,
								shadow = true,
							},
							staticcheck = true,
						},
					},
					-- Move your custom keymaps inside the LSP lifecycle attach function
					on_attach = function(client, bufnr)
						local opts = { noremap = true, silent = true, buffer = bufnr }
						vim.keymap.set("n", "<leader>ca", function()
							vim.lsp.buf.code_action()
						end, opts)
					end,
				},
			})
		end,
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all()',
	},

	-- Treesitter for Go syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "go", "gomod", "gowork", "gosum" },
		},
	},

	-- Formatter (Dedicated, fast on-save formatting)
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				-- goimports handles missing imports; gofumpt applies stricter formatting
				go = { "goimports", "gofumpt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},

	-- Debugging (DAP for Go)
	{
		"mfussenegger/nvim-dap",
		dependencies = { "leoluz/nvim-dap-go" },
		config = function()
			require("dap-go").setup()
		end,
		ft = "go",
	},
}
