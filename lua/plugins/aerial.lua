return {
  "stevearc/aerial.nvim",
  -- lazy = false,
  event = "User AstroFile",
  opts = {
    open_automatic = true,
    backends = { "treesitter", "lsp", "pyrighth", "markdown", "man" },
  },
}
