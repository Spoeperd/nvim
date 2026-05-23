return {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
        { 'DrKJeff16/wezterm-types', lazy = true },
    },
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = 'wezterm-types',      mods = { 'wezterm' } },
            { path = "snacks.nvim",        words = { "Snacks" } },
        },
    },
}
