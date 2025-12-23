-- lua/plugins/go.lua
return {
	-- Go development plugin
	{
		"ray-x/go.nvim",
		dependencies = { "ray-x/guihua.lua" },
		config = function()
			require("go").setup({
				lsp_cfg = true, -- enable Go LSP (gopls)
				lsp_keymaps = true, -- setup default keymaps
				lsp_codelens = true, -- enable codelens
				dap_debug = true, -- enable nvim-dap for Go debugging
				textobjects = true,
				gofumpt = true, -- format with gofumpt instead of gofmt

				-- ✅ gopls settings actually go here:
				gopls_settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							unusedwrite = true,
							shadow = true,
						},
						staticcheck = true,
					},
				},

				-- ✅ custom keymap setup
				on_attach = function(client, bufnr)
					local opts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "<leader>ca", function()
						vim.lsp.buf.code_action()
					end, opts)
					print("Keymap <leader>ca set for Go buffer")
				end,
			})
		end,

		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all()', -- install/update go tools
	},

	-- Treesitter for Go syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "go", "gomod", "gowork", "gosum" },
		},
	},

	-- LSP config
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gopls = {
					settings = {
						gopls = {
							analyses = { unusedparams = true, shadow = true },
							staticcheck = true,
						},
					},
				},
			},
		},
	},

	-- Formatter (uses goimports or gofumpt if installed)
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				go = { "goimports", "gofumpt" },
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
