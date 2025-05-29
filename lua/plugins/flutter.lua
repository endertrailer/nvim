return {
	"akinsho/flutter-tools.nvim",
	lazy = false,
	-- version = "1.13.0", -- Pinned to stable version
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
		"neovim/nvim-lspconfig",
		-- "jose-elias-alvarez/null-ls.nvim",
		-- "nvimtools/none-ls.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		-- Flutter Tools Setup
		require("flutter-tools").setup({
			flutter_path = "/home/endertrailer/snap/flutter/common/flutter/bin/flutter",

			ui = {
				border = "rounded", -- string
				notification_style = "plugin", -- added required field
			},

			decorations = {
				statusline = {
					app_version = true, -- boolean in table
					device = true, -- boolean in table
				},
			},

			widget_guides = {
				enabled = true, -- now properly nested in table
			},

			closing_tags = {
				highlight = "Comment", -- string in table
				prefix = "// ", -- string in table
				enabled = true, -- boolean in table
			},

			dev_log = {
				enabled = true, -- boolean in table
				open_cmd = "tabedit", -- added required field
			},

			lsp = {
				color = {
					enabled = true, -- properly nested
				},
				settings = {
					dart = {
						sdkPath = "/home/endertrailer/snap/flutter/common/flutter/bin/cache/dart-sdk",
						completeFunctionCalls = true, -- recommended addition
						showTodos = true, -- recommended addition
					},
				},
				on_attach = function(client, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts) -- moved inside on_attach
				end,
			},

			debugger = {
				enabled = true,
				run_via_dap = true,
				exception_breakpoints = { "raised", "uncaught" },
				register_configurations = function(_)
					require("dap").configurations.dart = {}
				end,
			},

			dev_tools = {
				autostart = true,
				auto_open_browser = false, -- added recommended field
			},
		})
		-- require("none-ls").setup({
		-- 	sources = { require("none-ls").builtins.formatting.dart_format },
		-- })
		-- Null-LS Setup (optional)

		-- require("null-ls").setup({
		-- 	sources = {
		-- 		require("null-ls").builtins.formatting.dart_format,
		-- 	},
		-- })
		config =
			function()
				local null_ls = require("null-ls")

				null_ls.setup({
					sources = {
						-- your tools (formatting, diagnostics, etc)
					},
				})
			end,
			-- Format on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.dart",
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})

		-- Flutter commands
		vim.api.nvim_create_user_command("FlutterRun", function()
			require("flutter-tools.commands").run()
		end, {})

		vim.api.nvim_create_user_command("FlutterDevices", function()
			require("flutter-tools.devices").list_devices()
		end, {})

		vim.api.nvim_create_user_command("FlutterDetach", function()
			require("flutter-tools.commands").detach()
		end, {})

		vim.api.nvim_create_user_command("FlutterRestart", function()
			require("flutter-tools.commands").restart()
		end, {})
	end,
	ft = "dart",
}
