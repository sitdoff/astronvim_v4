-- return {
--     {
--         "mfussenegger/nvim-dap-python",
--         dependencies = { "mfussenegger/nvim-dap" },
--         config = function()
--             -- Находим путь к python, который установил Mason специально для отладки
--             local mason_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
--
--             -- Если вы используете глобальный python, где есть debugpy, можно указать просто "python3"
--             -- Но путь через Mason надежнее, так как вы его уже установили в Шаге 1
--
--             -- Инициализируем плагин штатно
--             require("dap-python").setup(mason_path)
--
--             -- Учим nvim-dap игнорировать внутренние уведомления debugpy о сокетах,
--             -- чтобы они не вызывали ложных предупреждений (WARN) в логах Neovim
--             local dap = require "dap"
--             dap.listeners.before.event_debugpySockets = function() return true end
--             dap.listeners.before.event_debugpyWaitingForServer = function() return true end
--         end,
--     },
-- }

return {
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local mason_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(mason_path)

            -- Игнорируем внутренний шум debugpy в логах
            local dap = require "dap"
            dap.listeners.before.event_debugpySockets = function() return true end
            dap.listeners.before.event_debugpyWaitingForServer = function() return true end

            -- НАСТРОЙКА МАППИНГА ПУТЕЙ:
            -- Находим дефолтную конфигурацию "Remote Attach", которую создал nvim-dap-python
            for _, config in ipairs(dap.configurations.python or {}) do
                if config.request == "attach" then
                    config.subProcess = true -- Разрешаем отладку ветвлений и потоков
                    config.justMyCode = true -- Дебажим только свой код, игнорируя системные потоки Python
                    config.pathMappings = {
                        {
                            -- localRoot: путь к проекту на вашем ПК (берется автоматически текущая папка)
                            localRoot = vim.fn.getcwd(),

                            -- remoteRoot: путь, где это приложение запущено ФАКТИЧЕСКИ.
                            -- ЕСЛИ ВЫ ЗАПУСТИЛИ ПРОСТО В ТЕРМИНАЛЕ НА ТОЙ ЖЕ МАШИНЕ: оставьте vim.fn.getcwd()
                            -- ЕСЛИ В DOCKER: замените на путь внутри контейнера, например, "/app" или "/workspace"
                            remoteRoot = vim.fn.getcwd(),
                        },
                    }
                end
            end
        end,
    },
}
