return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            modules = {},
            ensure_installed = {
                "c", "lua", "vim", "vimdoc", "query",
                "markdown", "markdown_inline",
                "python", "bash", "json", "yaml",
            },
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },

        })
    end,
}
