-- init.lua
-- LazyVim configuration for Go development

-- General settings
-- vim.opt.number = true -- Show line numbers
-- vim.opt.tabstop = 4 -- Set tab width to 4 spaces
-- vim.opt.shiftwidth = 4 -- Set indentation width to 4 spaces
-- vim.opt.expandtab = true -- Use spaces instead of tabs
-- vim.opt.smartindent = true -- Enable smart indentation

-- Keybindings
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open file explorer" })

-- Bootstrap LazyVim
return {
	-- Default LazyVim plugins
	{ import = "lazyvim.plugins" },

	-- Go-specific plugins
	{
		"fatih/vim-go", -- Go development plugin
		ft = "go", -- Load only for Go files
		config = function()
			-- vim-go settings
			vim.g.go_fmt_command = "goimports" -- Use goimports instead of gofmt
			vim.g.go_highlight_types = 1 -- Highlight types
			vim.g.go_highlight_fields = 1 -- Highlight struct fields
			vim.g.go_highlight_functions = 1 -- Highlight functions
			vim.g.go_highlight_methods = 1 -- Highlight methods
			vim.g.go_highlight_operators = 1 -- Highlight operators
		end,
	},

	-- LSP configuration for Go
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls" }, -- Ensure gopls is installed
			})

			local lspconfig = require("lspconfig")
			lspconfig.gopls.setup({
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})

			-- Keybindings for LSP
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
		end,
	},

	-- Treesitter for better syntax highlighting

	-- Telescope for fuzzy finding
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "node_modules", "vendor" }, -- Ignore Go vendor directory
				},
			})

			-- Keybindings for Telescope
			vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
		end,
	},

	-- Debugging with nvim-dap
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			dap.adapters.go = {
				type = "executable",
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:38697" },
			}
			dap.configurations.go = {
				{
					type = "go",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
			}

			-- Keybindings for DAP
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue debugging" })
		end,
	},
}
