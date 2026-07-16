vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local _icons = {
    git_branch = "",
    error = " ",
    warn = " ",
    info = " ",
    hint = " ",
    added = " ",
    removed = " ",
    lock = "",
    modified = "●",
    search = " "
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

require("lualine").setup({
    options = {
        section_separators   = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        always_show_tabline = false,
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {
            {
                "buffers",
                show_filename_only = true,
                hide_filename_extension = false,
                show_modified_status = true,
                mode = 0, -- 0: name, 1: index, 2: name + index
                symbols = {
                    modified = " " .. _icons.modified,
                    alternate_file = "",
                    directory = "",
                },
            },

        },
        lualine_c = {},
        lualine_x = {
            search_count,
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
            "lsp_status",
            "branch",
        },
        lualine_y = {"progress"},
        lualine_z = {},
    },
})
