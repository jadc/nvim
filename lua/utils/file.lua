local M = {}

M.max_filesize = 1024 * 1024 -- 1 MB

function M.is_large(buf)
    local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
    return ok and stat and stat.size > M.max_filesize
end

return M
