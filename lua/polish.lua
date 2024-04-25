-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.html" },
  command = "set filetype=htmldjango",
})
vim.api.nvim_create_augroup("neotree_autoopen", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  desc = "Open Neotree on enter",
  group = "neotree_autoopen",
  once = true,
  callback = function()
    if not vim.g.neotree_opened then
      vim.cmd "Neotree focus"
      vim.g.neotree_opened = true
    end
  end,
})
require("luasnip").filetype_extend("htmldjango", { "html" })
