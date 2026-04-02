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
if vim.env.TMUX then
    require("plugins.vim-tmux-navigator")
end
require("plugins.visual-whitespace")
require("plugins.conform")

-- Defaults
require("options")
require("mappings")
require("lsp")
require("autocmds")
