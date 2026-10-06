vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

local saved_showtabline

require("diffview").setup({
    view = {
        default = { winbar_info = false },
        merge_tool = { winbar_info = false },
        file_history = { winbar_info = false },
    },
    hooks = {
        view_post_layout = function(view)
            -- Flag stops dropbar attaching; clearing removes winbars inherited from `tab split`.
            -- Windows later split in this tab inherit the empty winbar.
            vim.t[view.tabpage].diffview_hide_ui = true
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(view.tabpage)) do
                vim.wo[win].winbar = ""
            end
        end,
        view_enter = function()
            saved_showtabline = saved_showtabline or vim.o.showtabline
            vim.o.showtabline = 0
        end,
        view_leave = function(view)
            -- Closing a background view must not affect the active view.
            if view.tabpage == vim.api.nvim_get_current_tabpage() and saved_showtabline then
                vim.o.showtabline = saved_showtabline
                saved_showtabline = nil
            end
        end,
    },
})
