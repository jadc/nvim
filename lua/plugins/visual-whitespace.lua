vim.pack.add({ "https://github.com/mcauley-penney/visual-whitespace.nvim" })

require("visual-whitespace").setup()

-- Highlight trailing whitespace
vim.opt.list = true
vim.opt.listchars:append({ trail = "·", tab = "▏ " })
