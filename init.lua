vim.g.mapleader = " "

-- Themes
require("themes.onedark")

-- Plugins
require("plugins.cmp")
require("plugins.dropbar")
require("plugins.flash")
require("plugins.fugitive")
require("plugins.gitsigns")
require("plugins.lualine")
require("plugins.scope")
require("plugins.fzf-lua")
require("plugins.treesitter")
require("plugins.mini-cursorword")
require("plugins.visual-whitespace")
require("plugins.conform")
require("plugins.guess-indent")
require("plugins.roslyn")
require("plugins.fidget")

-- Defaults
require("options")
require("mappings")
require("lsp")
require("autocmds")
