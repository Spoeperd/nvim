return {
	"mbbill/undotree",
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
	},
    init = function()
        vim.g.undotree_SetFocus = 1
    end,
}
