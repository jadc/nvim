vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })

local fidget = require("fidget")

fidget.setup({
    notification = {
        override_vim_notify = true,
        configs = {
            -- No "Notifications ❰❰" group header
            default = vim.tbl_extend("force", fidget.notification.default_config, {
                name = false,
                icon = false,
            }),
        },
        window = {
            -- Opaque toasts over a transparent background
            winblend = 0,
        },
    },
})

local group = vim.api.nvim_create_augroup("FidgetNotify", { clear = true })

-- Show macro recording status as toasts
local macro_key = "macro-recording"
vim.api.nvim_create_autocmd("RecordingEnter", {
    group = group,
    callback = function()
        fidget.notify("Recording @" .. vim.fn.reg_recording(), vim.log.levels.INFO, {
            key = macro_key,
            annote = "MACRO",
            ttl = math.huge, -- persist while recording
        })
    end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
    group = group,
    callback = function()
        -- Re-emit the same key with a short ttl so the toast fades out
        fidget.notify("Recorded @" .. vim.fn.reg_recording(), vim.log.levels.INFO, {
            key = macro_key,
            annote = "MACRO",
            ttl = 1.5,
        })
    end,
})

-- Show vim.pack install/update/delete as toasts
vim.api.nvim_create_autocmd("PackChanged", {
    group = group,
    callback = function(ev)
        fidget.notify(ev.data.spec.name, vim.log.levels.INFO, {
            annote = "PACK " .. ev.data.kind,
        })
    end,
})

-- Show file save as toasts
vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    callback = function(ev)
        local name = vim.fn.fnamemodify(ev.file, ":~:.")
        fidget.notify(name, vim.log.levels.INFO, { annote = "saved" })
    end,
})

-- Show yanks as toasts
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        local ev = vim.v.event
        if ev.operator ~= "y" then return end
        local n = #ev.regcontents
        fidget.notify(("yanked %d line%s"):format(n, n == 1 and "" or "s"),
            vim.log.levels.INFO, { annote = "yank" })
    end,
})
