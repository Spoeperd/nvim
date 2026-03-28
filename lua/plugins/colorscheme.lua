return {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        -- Load the colorscheme
        vim.cmd.colorscheme("rose-pine")
    end,
}
