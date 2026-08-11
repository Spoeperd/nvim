return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
			lua = { "stylua" },
			markdown = { "prettier" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
