vim.pack.add({ "https://github.com/NMAC427/guess-indent.nvim" })

require("guess-indent").setup()

-- Fallback
local tabsize = 4
--- Tabs as spaces
vim.opt.expandtab = true
--- Tab size
vim.opt.shiftwidth = tabsize
vim.opt.softtabstop = tabsize
vim.opt.tabstop = tabsize
