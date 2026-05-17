return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        -- Load the colorscheme
        vim.cmd.colorscheme("catppuccin")
    end,
}
