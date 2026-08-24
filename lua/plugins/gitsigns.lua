vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

vim.opt.signcolumn = "yes"
require("gitsigns").setup({
    numhl = true,
    signcolumn = true,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = false,
    },

    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
            if vim.wo.diff then
                vim.cmd.normal({"]h", bang = true})
            else
                gitsigns.nav_hunk("next")
            end
        end)

        map("n", "[h", function()
            if vim.wo.diff then
                vim.cmd.normal({"[h", bang = true})
            else
                gitsigns.nav_hunk("prev")
            end
        end)

        -- Actions

        -- Load the current line's history into the quickfix list.
        local function line_history()
            local line = vim.fn.line(".")
            local ok, err = pcall(function()
                vim.cmd(string.format("Gclog! -L %d,%d:%%", line, line))
            end)
            if not ok then
                vim.notify(tostring(err), vim.log.levels.ERROR)
                return
            end

            if vim.fn.getqflist({ size = 0 }).size == 0 then
                vim.notify("No commits found for this line", vim.log.levels.WARN)
                return
            end

            vim.cmd.copen()
        end
        map("n", "<leader>hb", line_history)

        map("n", "<leader>hh", gitsigns.preview_hunk_inline)
        map("n", "<leader>hs", gitsigns.stage_hunk)
        map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("n", "<leader>hr", gitsigns.reset_hunk)
        map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
    end
})
