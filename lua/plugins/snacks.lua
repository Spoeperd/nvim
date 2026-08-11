return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		indent = { enabled = true },
		picker = {
			enabled = true,
			icons = {
				diagnostics = {
					Error = "●",
					Warn = "●",
					Hint = "●",
					Info = "●",
				},
			},
			sources = {
				explorer = {
					focus = "list",
					auto_close = true,
					hidden = true,
					ignored = true,
				},
			},
		},
		explorer = {
			enabled = true,
			replace_netrw = true,
		},
		dashboard = { enabled = true },
		notifier = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{
			"<leader>pf",
			function()
				Snacks.picker.files()
			end,
			desc = "Snacks: Find Files",
		},
		{
			"<leader>ps",
			function()
				Snacks.picker.grep()
			end,
			desc = "Snacks: Live Grep",
		},
		{
			"<leader>pe",
			function()
				Snacks.explorer()
			end,
			desc = "Snacks: Explorer",
		},
		{
			"<leader>pd",
			function()
				Snacks.explorer({ focus = "input" })
			end,
			desc = "Snacks: Find Directories",
		},

		{
			"<leader>gs",
			function()
				Snacks.lazygit()
			end,
			desc = "Git: Toggle Status & Panel (LazyGit)",
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git: Blame Line (Inline Virtual Text)",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git: View File Diff Changes",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git: View Commit Log History",
		},

		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Go to definition",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "Go to references",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Go to implementation",
		},
		{
			"<leader>D",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Type definition",
		},
		{
			"<leader>ds",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Document symbols",
		},
		{
			"<leader>ws",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "Workspace symbols",
		},
	},
}
