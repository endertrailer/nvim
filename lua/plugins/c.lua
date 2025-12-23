-- ~/.config/nvim/lua/plugins/c.lua
return {
	-- LSP config using LazyVim-style setup
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = {},
			},
			setup = {
				clangd = function(_, opts)
					-- Load LazyVim utility module
					local Util = require("lazyvim.util")

					opts.on_attach = function(client, bufnr)
						-- LazyVim's default on_attach
						Util.lsp.on_attach(client, bufnr)

						-- Custom keymaps
						local bufopts = { buffer = bufnr, noremap = true, silent = true }
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
						vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
						vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
						vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
					end

					return false -- don't skip default setup
				end,
			},
		},
	},

	-- Ensure Mason installs clang tools
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"clangd",
				"clang-format",
			},
		},
	},

	-- Formatter: conform.nvim
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
			},
		},
	},

	-- Linter (optional): nvim-lint

	-- Build & Run commands
	{
		"nvim-lua/plenary.nvim",
		config = function()
			vim.api.nvim_create_user_command("CppBuild", function()
				vim.cmd("!g++ -std=c++20 -Wall % -o %<")
			end, {})
			vim.api.nvim_create_user_command("CppRun", function()
				vim.cmd("!./%<")
			end, {})
		end,
	},
}
