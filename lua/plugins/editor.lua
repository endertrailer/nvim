return {
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			-- Disable the default <Tab> binding so it doesn't break your snippet engine or completion menu
			vim.g.codeium_no_map_tab = true

			-- Accept completion: Ctrl + L
			vim.keymap.set("i", "<C-l>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true, replace_keycodes = false })

			-- Cycle through suggestions: Alt + ] / Alt + [
			vim.keymap.set("i", "<A-]>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })

			vim.keymap.set("i", "<A-[>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })

			-- Clear current suggestion: Ctrl + X
			vim.keymap.set("i", "<C-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},
}
