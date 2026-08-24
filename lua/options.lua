-- Options
local opts = {
    --- Disable backups
    backup = false,
    swapfile = false,
    undofile = true,
    writebackup = false,

    --- Tabs, Wrapping, and Spacing
    breakindent = true,  -- Maintain indent when wrapping
    linebreak = true,    -- Don't cut words while wrapping

    --- Visibility
    cmdheight = 0,              -- Hide command line
    number = true,              -- Show line numbers
    fillchars = { eob = " " },  -- Hide `~` past the end of the buffer
    --- Folding
    foldlevel = 20,

    --- Search
    hlsearch = true,    -- Enables search highlight
    ignorecase = true,  -- Case insensitive search
    smartcase = true,   -- Sensitive if search has caps

    --- Miscellaneous
    clipboard = "unnamedplus",  -- Use system clipboard
    autoread = true,            -- Reload unmodified files changed outside Neovim
    winborder = "rounded",      -- Rounded window borders
    updatetime = 250,           -- Faster CursorHold for LSP highlights
    timeoutlen = 300,           -- Faster mapping-sequence timeout
}

for k, v in pairs(opts) do
    vim.opt[k] = v
end

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable right-click menu
vim.cmd.aunmenu("PopUp")
