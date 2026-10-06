local M = {}
local ns = vim.api.nvim_create_namespace("git-line-history")
local seq = 0

local function notice(message, level)
    vim.notify("Line history: " .. message, level or vim.log.levels.WARN)
end

function M.show()
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()
    local path = vim.api.nvim_buf_get_name(buf)
    if vim.bo[buf].buftype ~= "" or vim.fn.filereadable(path) == 0 then
        notice("Current buffer has no available file on disk")
        return
    end

    local line = vim.api.nvim_win_get_cursor(win)[1]
    local tick = vim.api.nvim_buf_get_changedtick(buf)
    seq = seq + 1
    local id = seq

    local args = { "git", "--no-pager", "log", "-5", "--no-patch", "--format=%H%x00%an%x00%s%x00",
        string.format("-L%d,%d:%s", line, line, vim.fs.basename(path)), "HEAD" }
    local ok, err = pcall(vim.system, args, { cwd = vim.fs.dirname(path), text = true },
        vim.schedule_wrap(function(result)
            -- Drop stale results: newer request, or the cursor/buffer moved on.
            if id ~= seq
                or vim.api.nvim_get_current_win() ~= win
                or vim.api.nvim_get_current_buf() ~= buf
                or vim.api.nvim_buf_get_changedtick(buf) ~= tick
                or vim.api.nvim_win_get_cursor(win)[1] ~= line
            then
                return
            end
            if result.code ~= 0 then
                local detail = vim.trim(result.stderr or "")
                notice(detail ~= "" and detail or ("git exited " .. result.code), vim.log.levels.ERROR)
                return
            end

            local contents = {}
            for hash, author, subject in result.stdout:gmatch("(%x+)%z(.-)%z(.-)%z") do
                -- Keep Git metadata on one readable display line.
                contents[#contents + 1] = hash:sub(1, 8) .. "  " .. author:gsub("%c", " ")
                contents[#contents + 1] = "  " .. subject:gsub("%c", " ")
            end
            if #contents == 0 then
                notice("No commits found for this line in HEAD")
                return
            end

            local float_buf = vim.lsp.util.open_floating_preview(contents, "text", {
                border = "rounded",
                focus = false,
                max_width = 90,
                max_height = 20,
                close_events = { "CursorMoved", "CursorMovedI", "InsertCharPre" },
            })
            for row = 0, #contents - 1, 2 do
                vim.api.nvim_buf_set_extmark(float_buf, ns, row, 0, {
                    end_col = #contents[row + 1],
                    hl_group = "Comment",
                })
            end
        end))
    if not ok then
        notice("Could not run Git: " .. tostring(err), vim.log.levels.ERROR)
    end
end

return M
