vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

-- Don't print mode, lualine handles it
vim.o.showmode = false

local _icons = {
    error = " ",
    git_branch = "",
    hint = " ",
    info = " ",
    lock = "",
    modified = "●",
    search = " ",
    warn = " ",
}

local function search_count()
    if vim.v.hlsearch == 0 then
        return ""
    end

    local ok, count = pcall(vim.fn.searchcount, {
        recompute = true,
        maxcount = 999,
        timeout = 50,
    })

    if not ok or count.total == 0 then
        return ""
    end

    local total = count.incomplete == 2 and ">" .. count.maxcount or count.total
    return string.format("%s%d/%s", _icons.search, count.current, total)
end

local theme = require("lualine.themes.auto")

-- Transparent bar background
local TRANSPARENT = "NONE"
theme.normal.c.bg = TRANSPARENT
theme.inactive.a.bg = TRANSPARENT
theme.inactive.b.bg = TRANSPARENT
theme.inactive.c.bg = TRANSPARENT
vim.api.nvim_set_hl(0, "StatusLine", { bg = TRANSPARENT })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = TRANSPARENT })
vim.api.nvim_set_hl(0, "StatusLineTerm", { bg = TRANSPARENT })
vim.api.nvim_set_hl(0, "StatusLineTermNC", { bg = TRANSPARENT })

require("lualine").setup({
    options = {
        theme = theme,
        section_separators   = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        always_show_tabline = false,
        globalstatus = true,  -- One statusline for whole screen
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {},
        lualine_c = {
            {
                "filename",
                path = 4, -- filename and immediate parent
                symbols = {
                    modified = "" .. _icons.modified,
                    readonly = "" .. _icons.lock,
                    unnamed = "—",
                },
            },
        },
        lualine_x = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = {
                    error = _icons.error,
                    warn  = _icons.warn,
                    info  = _icons.info,
                    hint  = _icons.hint
                },
                diagnostics_color = {
                    error = { fg = "#dd3300" },
                    warn =  { fg = "#eedd00" },
                    info =  { fg = "#445455" },
                    hint =  { fg = "#88aaaa" }
                }
            },
            {
                "branch",
                icon = _icons.git_branch,
            },
        },
        lualine_y = {
            search_count,
            "progress"
        },
        lualine_z = {},
    },
})
