if vim.env.WSL_DISTRO_NAME or vim.env.WSL_INTEROP then
	local paste =
		[[powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))]]

	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
		cache_enabled = 0,
	}
end

-- Use the system clipboard for unnamed registers.
vim.opt.clipboard = "unnamedplus"

local function copy_location(visual)
	local path = vim.fn.expand("%:.")
	if path == "" then
		vim.notify("Current buffer has no file path", vim.log.levels.WARN)
		return
	end

	local first = vim.fn.line(".")
	local location = path .. ":" .. first
	if visual then
		-- Use the active selection, not marks from the previous selection.
		local anchor = vim.fn.line("v")
		first, anchor = math.min(first, anchor), math.max(first, anchor)
		location = path .. ":" .. first .. "-" .. anchor
	end

	vim.fn.setreg('"', location, "v")
	if vim.fn.has("clipboard") == 1 then
		vim.fn.setreg("+", location, "v")
	end
end

vim.keymap.set("n", "Y", function()
	copy_location(false)
end, {
	desc = "Copy relative file path and line",
})
vim.keymap.set("x", "Y", function()
	copy_location(true)
	vim.cmd.normal({ args = { "\27" }, bang = true })
end, {
	desc = "Copy relative file path and line range",
})
