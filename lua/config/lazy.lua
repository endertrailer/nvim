local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.filetype.add({
	extension = {
		ejs = "html",
	},
})

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	spec = {
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				colorscheme = "tokyonight-night",
				news = {
					lazyvim = true,
					neovim = true,
				},
				inlay_hints = { enabled = false },
			},
		},

		-- Additional language support
		{ import = "lazyvim.plugins.extras.linting.eslint" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		-- Emmet configuration
		{
			"neovim/nvim-lspconfig",
			config = function()
				local lspconfig = require("lspconfig")

				-- Set up Emmet language server
				lspconfig.emmet_ls.setup({
					filetypes = {
						"html",
						"css",
						"scss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						-- Add more file types if needed
					},
					init_options = {
						html = {
							options = {
								-- Set Emmet to use `className` instead of `class` for React JSX
								["jsx.className"] = true,
							},
						},
					},
				})
			end,
		},
		-- Code runner
		{ "CRAG666/code_runner.nvim", config = true },
		{ "rafamadriz/friendly-snippets", enabled = false },
		-- Miscellaneous configurations
		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
		{ import = "plugins" },
	},
	defaults = {
		lazy = false,
		version = false,
	},
	dev = {
		path = "~/.ghq/github.com",
	},
	checker = { enabled = true },
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	debug = false,
})
