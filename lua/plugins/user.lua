-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
      luasnip.filetype_extend("html", { "htmldjango" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup "~/.virtualenvs/debugpy/bin/python"
      local dap = require "dap"
      -- dap.adapters.python = {
      -- 	type = "executable",
      -- 	command = "~/.virtualenvs/debugpy/bin/python",
      -- 	args = { "-m", "debugpy.adapter" },
      -- }
      --
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Django",
        program = vim.fn.getcwd() .. "/manage.py", -- NOTE: Adapt path to manage.py as needed
        args = { "runserver", "--noreload" },
      })
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Django tests",
        program = vim.fn.getcwd() .. "/manage.py", -- NOTE: Adapt path to manage.py as needed
        args = { "test" },
      })
      table.insert(dap.configurations.python, {
        type = "python",
        request = "attach",
        name = "Attach remote (with path mapping)",
        connect = function()
          local host = vim.fn.input "Host [127.0.0.1]: "
          host = host ~= "" and host or "127.0.0.1"
          local port = tonumber(vim.fn.input "Port [5678]: ") or 5678
          return { host = host, port = port }
        end,
        pathMappings = function()
          local cwd = "${workspaceFolder}"
          local local_path = vim.fn.input("Local path mapping [" .. cwd .. "]: ")
          local_path = local_path ~= "" and local_path or cwd
          local remote_path = vim.fn.input "Remote path mapping [.]: "
          remote_path = remote_path ~= "" and remote_path or "."
          return { { localRoot = local_path, remoteRoot = remote_path } }
        end,
      })
    end,
  },
}
