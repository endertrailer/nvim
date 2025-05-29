return {

	{
		"nvim-neorg/neorg",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Default modules
					-- ["core.concealer"] = {}, -- Icons & highlights
					["core.dirman"] = { -- Directory management
						config = {
							workspaces = {
								notes = "~/Documents/neorg",
								work = "~/Documents/neorg/work",
							},
							default_workspace = "notes",
						},
					},
					["core.keybinds"] = {
						config = {
							default_keybinds = true,
							neorg_leader = "<Leader>o",
						},
					},
					["core.qol.toc"] = {}, -- Table of contents
					["core.export"] = {}, -- Export notes
				},
			})
		end,
	},
}
