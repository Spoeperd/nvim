return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>pv", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
    },
    config = function()
        require("nvim-tree").setup({
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true, -- Shows an icon on the parent folder too
                icons = {
                    hint = "⚑",
                    info = "»",
                    warning = "▲",
                    error = "✘",
                },
            },
        })
    end,
}
