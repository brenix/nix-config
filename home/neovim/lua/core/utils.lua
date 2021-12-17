local M = {}

-- https://github.com/ChristianChiarulli/nvcode/blob/12c2b7dbad5dcd3b25d6e3cde62bd55eb7fb8df3/lua/nv-utils/init.lua#L3-L23
function M.set_augroup(group_name, definition)
	vim.cmd("augroup " .. group_name)
	vim.cmd("autocmd!")

	for _, def in pairs(definition) do
		-- local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
		local command = "autocmd " .. table.concat(def, " ")
		vim.cmd(command)
	end

	vim.cmd("augroup END")
end

return M
