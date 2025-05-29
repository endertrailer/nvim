-- init.lua
-- LazyVim configuration for Rust development

-- General settings
vim.opt.number = true -- Show line numbers
vim.opt.tabstop = 4 -- Set tab width to 4 spaces
vim.opt.shiftwidth = 4 -- Set indentation width to 4 spaces
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Enable smart indentation

-- Keybindings
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open file explorer" })

-- Bootstrap LazyVim
return {
	-- Default LazyVim plugins
	{ import = "lazyvim.plugins" },

	-- Rust-specific plugins
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		ft = "rust", -- Load only for Rust files
		config = function()
			-- Configure rustaceanvim
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(_, bufnr)
						-- Format on save
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})

						-- Keybindings for LSP
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
						vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go to references" })
						vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
						vim.keymap.set(
							"n",
							"<leader>ca",
							vim.lsp.buf.code_action,
							{ buffer = bufnr, desc = "Code actions" }
						)
						vim.keymap.set(
							"n",
							"<leader>rn",
							vim.lsp.buf.rename,
							{ buffer = bufnr, desc = "Rename symbol" }
						)
					end,
					settings = {
						["rust-analyzer"] = {
							procMacro = { enable = false },
						},
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy", -- Use clippy for linting
							},
						},
					},
				},
			}
		end,
	},

	-- Treesitter for better syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "rust" }, -- Ensure Rust parser is installed
			highlight = {
				enable = true,
			},
		},
	},

	-- Telescope for fuzzy finding
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "target", "node_modules" }, -- Ignore Rust target directory
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
			dap.adapters.lldb = {
				type = "executable",
				command = "lldb-vscode", -- Adjust this if needed
				name = "lldb",
			}
			dap.configurations.rust = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}

			-- Keybindings for DAP
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue debugging" })
		end,
	},

	-- Autocompletion with nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
			"hrsh7th/cmp-path", -- Path source for nvim-cmp
			"L3MON4D3/LuaSnip", -- Snippets plugin
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
