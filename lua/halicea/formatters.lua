require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "black" },
		mojo = { "black" },

		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd" } },
		html = { "prettierd" },

		go = { "gofmt", "goimports" },

        json = { "prettierd", "jq" },

		_default = { "prettierd" },
	},
})
