local plugins = {
	"autopairs",
	"better-escape",
	"bufferline",
	"circles",
	"cmp",
	"colorizer",
	"comment",
	"git-blame",
	"gitsigns",
	"go",
	"indentline",
	"lsp-rooter",
	"lsp-signature",
	"lspconfig",
	"lspkind",
	"lualine",
	"navigator",
	"null-ls",
	"nvim-tree",
	-- "rnvimr",
	"stabilize",
	"telescope",
	"todo-comments",
	"treesitter",
	"trouble",
}

for _, plugin in ipairs(plugins) do
	local ok, err = pcall(require, "plugins." .. plugin)
	if not ok then
		error("Error loading " .. plugin .. "\n\n" .. err)
	end
end
