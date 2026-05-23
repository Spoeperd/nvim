return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = { enabled = true },
        dashboard = { enabled = true },
        notifier = { enabled = true },
    },
    keys = {
        { "<leader>pf", function() Snacks.picker.files() end, desc = "Snacks: Find Files" },
        { "<leader>ps", function() Snacks.picker.grep() end,  desc = "Snacks: Live Grep" },
    },
}
