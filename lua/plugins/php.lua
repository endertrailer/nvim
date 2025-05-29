return {
	-- PHP Language Server (LSP)
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	opts = {
	-- 		servers = {
	-- 			phpactor = {
	-- 				cmd = { "phpactor", "language-server" },
	-- 				filetypes = { "php" },
	-- 				root_dir = function()
	-- 					return vim.fn.getcwd()
	-- 				end,
	-- 			},
	-- 		},
	-- 	},
	-- },

	-- PHP Language Server (LSP)
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				intelephense = {
					filetypes = { "php" },
					root_dir = function(fname)
						return require("lspconfig.util").root_pattern("composer.json", ".git")(fname) or vim.fn.getcwd()
					end,
				},
			},
		},
	},
	-- Treesitter for PHP syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "php" })
			end
		end,
	},

	-- PHP-specific keymaps
	{
		"LazyVim/LazyVim",
		opts = {
			autocmds = {
				php = {
					{
						"FileType",
						"php",
						function()
							-- Set PHP-specific settings
							vim.opt_local.tabstop = 4
							vim.opt_local.shiftwidth = 4
							vim.opt_local.softtabstop = 4
							vim.opt_local.expandtab = false -- Use tabs (common in PHP)

							-- Keymaps for PHP
							vim.keymap.set("n", "<leader>ct", ":!php artisan test<CR>", { desc = "Run PHP tests" })
							vim.keymap.set(
								"n",
								"<leader>cf",
								":!php-cs-fixer fix %<CR>",
								{ desc = "Fix PHP formatting" }
							)
						end,
					},
				},
			},
		},
	},

	-- Additional PHP tooling (optional)
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				php = { "php_cs_fixer" }, -- Requires php-cs-fixer
			},
		},
	},
}
