return {
    "mbbill/undotree",
    init = function()
        vim.g.undotree_SetFocusWhenToggle = 1
    end,
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
    },
}
