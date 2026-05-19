-- Customize None-ls sources

-- ---@type LazySpec
-- return {
--     "nvimtools/none-ls.nvim",
--     opts = function(_, config)
--         -- config variable is the default configuration table for the setup function call
--         -- local null_ls = require "null-ls"
--
--         -- Check supported formatters and linters
--         -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
--         -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
--         config.sources = {
--             -- Set a formatter
--             -- null_ls.builtins.formatting.stylua,
--             -- null_ls.builtins.formatting.prettier,
--             -- null_ls.builtins.formatting.prettierd,
--             -- null_ls.builtins.diagnostics.flake8,
--             -- null_ls.builtins.diagnostics.djlint,
--             -- null_ls.builtins.formatting.stylua,
--             -- null_ls.builtins.formatting.black,
--             -- null_ls.builtins.formatting.isort,
--             -- null_ls.builtins.formatting.djlint,
--         }
--         return config -- return final config table
--     end,
-- }
--

return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            -- Добавляем внешние линтеры, которые удалили из ядра none-ls
            "nvimtools/none-ls-extras.nvim",
        },
        opts = function(_, opts)
            opts.sources = opts.sources or {}

            -- Подключаем flake8 из пакета extras вместо null-ls.builtins
            table.insert(
                opts.sources,
                require("none-ls.diagnostics.flake8").with {
                    -- Опционально: настраиваем длину строки под современные стандарты
                    extra_args = { "--max-line-length", "120" },
                }
            )
        end,
    },
}
