vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' }
})

local file = require("utils.file")

-- Cached list of parsers nvim-treesitter knows how to install
local available

--- Attach treesitter to a buffer, if its parser is loadable
local function start(buf, lang)
    if not vim.api.nvim_buf_is_valid(buf) then return end
    if not vim.treesitter.language.add(lang) then return end

    vim.treesitter.start(buf, lang)
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.wo[win][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[win][0].foldmethod = "expr"
    end
end

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
    pattern = { "*" },
    callback = function(args)
        local buf = args.buf

        -- Skip large files to avoid freezing
        if file.is_large(buf) then return end

        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then return end

        -- Parser already available, attach immediately
        if vim.treesitter.language.add(lang) then
            start(buf, lang)
            return
        end

        available = available or require("nvim-treesitter").get_available()
        if not vim.tbl_contains(available, lang) then return end

        -- install() is async and returns a Task, so attach once it resolves
        require("nvim-treesitter").install(lang):await(vim.schedule_wrap(function(err)
            if err then return end
            start(buf, lang)
        end))
    end,
})
