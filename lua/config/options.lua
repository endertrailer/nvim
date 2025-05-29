vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

-- Automatically format Dart files before saving
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*.dart",
-- 	callback = function()
-- 		vim.lsp.buf.format()
-- 	end,
-- })
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"

vim.opt.runtimepath:prepend("~/.config/nvim/override")
-- vim.opt.mouse = ""
vim.opt.relativenumber = true
vim.g.python3_host_prog = "~/AutoGen/.venv/bin/python"
-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })
vim.g.lazyvim_python_lsp = "pyright"
